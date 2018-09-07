require 'yaml'

# TODO: Create a currency class?
module Fafx
  class ER
    attr_reader :rates
    def initialize
      @rates = load_data
    end

    private
    # -> Hash[String => Float]
    def load_data
      rates = "#{File.join(File.dirname(__FILE__))}/rates.yaml"
      DataFetcher.save_to_disk if not File.exist?(rates)
      YAML.load_file(rates)
    end
  end
end
