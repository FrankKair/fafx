require 'open-uri'
require 'nokogiri'

module DataFetcher
  def save_to_disk
    url = 'https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'
    doc = Nokogiri::XML(open(url))
    rates = process_currencies_xml(doc)
    dir = "#{File.join(File.dirname(__FILE__))}/rates.yaml"
    File.open(dir, 'w') { |f| f << rates.to_yaml }
  end

  private

  def process_currencies_xml(doc)
    rates = {}
    doc.css('Cube>Cube[time]').each do |day|
      time = day[:time]
      rates[time] = {}
      day.css('Cube').each do |currency|
        # TODO: Think about float value - type safety
        rates[time][currency[:currency]] = currency[:rate].to_f
      end
    end
    rates
  end

  module_function :save_to_disk, :process_currencies_xml
end
