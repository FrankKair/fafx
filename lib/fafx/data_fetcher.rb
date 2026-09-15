# frozen_string_literal: true

require 'fileutils'
require 'open-uri'
require 'nokogiri'
require 'tempfile'
require 'yaml'

module Fafx
  module DataFetcher
    ECB_90_DAY_RATES_URL =
      'https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'

    def save_to_disk(path = default_path)
      rates = fetch_rates
      write_rates(path, rates)
      rates
    rescue OpenURI::HTTPError, SocketError, IOError, SystemCallError,
           Nokogiri::XML::SyntaxError => e
      raise DataError, "Unable to update exchange rate data: #{e.message}"
    end

    def default_path
      base = ENV.fetch('XDG_DATA_HOME', File.join(Dir.home, '.local', 'share'))
      File.join(base, 'fafx', 'rates.yaml')
    end

    def fetch_rates
      URI.open(
        ECB_90_DAY_RATES_URL,
        open_timeout: 10,
        read_timeout: 10
      ) do |response|
        doc = Nokogiri::XML(response)
        process_currencies_xml(doc)
      end
    end

    def write_rates(path, rates)
      FileUtils.mkdir_p(File.dirname(path))

      Tempfile.create(['fafx-rates', '.yaml'], File.dirname(path)) do |file|
        file.write(rates.to_yaml)
        file.flush
        File.rename(file.path, path)
      end
    end

    private

    def process_currencies_xml(doc)
      rates = {}

      doc.css('Cube>Cube[time]').each do |day|
        time = day[:time]
        rates[time] = { 'EUR' => 1.0 }

        day.css('Cube').each do |currency|
          rates[time][currency[:currency]] = currency[:rate].to_f
        end
      end

      raise DataError, 'No exchange data was returned' if rates.empty?

      rates
    end

    module_function :save_to_disk,
                    :default_path,
                    :fetch_rates,
                    :write_rates,
                    :process_currencies_xml
  end
end
