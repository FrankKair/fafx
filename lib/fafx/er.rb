require 'yaml'

# TODO: Create a currency class?
module Fafx
  class ER
    attr_reader :rates, :dates, :currencies
    def initialize
      data = load_data
      @rates = data
      @dates = data.keys
      @currencies = @rates[@dates.first].keys
    end

    def rates_at(date, curr)
      raise KeyError, 'Date not available' unless @dates.include?(date)
      raise KeyError, "#{curr} not found" unless @currencies.include?(curr)
      @rates[date][curr]
    end

    private

    # -> Hash[String => Float]
    def load_data
      rates = "#{File.join(File.dirname(__FILE__))}/rates.yaml"
      DataFetcher.save_to_disk unless File.exist?(rates)
      YAML.load_file(rates)
    end
  end
end
