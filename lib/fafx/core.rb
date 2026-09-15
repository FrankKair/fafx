# frozen_string_literal: true

require 'yaml'

module Fafx
  class Core
    class << self
      def default
        @default ||= new
      end

      def reset!
        @default = nil
      end
    end

    attr_reader :rates, :dates, :currencies

    def initialize(data = load_data)
      @rates = data
      @dates = data.keys
      @currencies = @rates[@dates.first].keys
    end
  
    def rate(curr)
      raise CurrencyError, "#{curr} not found" unless @currencies.include?(curr)
      @rates[@dates.first][curr]
    end
  
    def rates_at(date, curr)
      date = nearest_date(date)
      raise CurrencyError, "#{curr} not found" unless @currencies.include?(curr)
      @rates[date][curr]
    end
  
    private

    def nearest_date(date)
      return date if @dates.include?(date)
      found = @dates.find { |d| d <= date }
      raise DateError, 'Date not available' unless @dates.include?(date)
      found
    end
  
    def load_data
      path = DataFetcher.default_path
      Fafx::ExchangeRate.update_data unless File.exist?(rates)
      data = YAML.safe_load(File.read(path), permitted_classes: [], aliases: false)
      raise DataError, 'Exchange rate data is empty' unless data.is_a?(Hash) && !data.empty?

      data
    rescue Psych::Exception => e
      raise DataError, "Unable to load exchange rate data: #{e.message}"
    end
  end
end
