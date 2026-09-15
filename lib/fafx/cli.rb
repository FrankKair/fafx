# frozen_string_literal: true

require 'optparse'

module Fafx
  module CLI
    module_function

    def run(argv = ARGV, out: $stdout, err: $stderr)
      parser = option_parser
      args = argv.dup
      args = ['--help'] if args.empty?
      options = {}

      parser.parse!(args, into: options)
      return write_help(parser, out) if options[:help]

      unless args.empty?
        err.puts("invalid option: #{args.first}")
        return 1
      end

      execute(options, out)
    rescue OptionParser::ParseError => e
      err.puts(e.message)
      err.puts(parser)
      1
    rescue StandardError => e
      err.puts(e.message) unless e.message == 'exit'
      1
    end

    def option_parser
      OptionParser.new do |opt|
        opt.banner = 'Usage: fafx [options]'
        opt.on('--recent', 'List most recent rates') { |value| value }
        opt.on('--currencies', 'List available currencies') { |value| value }
        opt.on('--dates', 'List available dates') { |value| value }
        opt.on('--update', 'Fetches new data from the web') { |value| value }
        opt.on('-v', '--version', 'Shows version') { |value| value }
        opt.on('-h', '--help', 'Show this help message') { |value| value }
      end
    end

    def execute(options, out)
      return write_help(option_parser, out) if options.empty?

      options.each_key do |command|
        case command
        when :recent
          Fafx::ExchangeRate.most_recent.each_pair do |currency, rate|
            out.puts("#{currency} #{rate}")
          end
        when :currencies
          out.puts(Fafx::ExchangeRate.currencies_available)
        when :dates
          out.puts(Fafx::ExchangeRate.dates_available)
        when :update
          Fafx::ExchangeRate.update_data
          out.puts('Exchange rates data updated!')
        when :version
          out.puts("fafx #{Fafx::VERSION}")
        end
      end

      0
    end

    def write_help(parser, out)
      out.puts(parser)
      0
    end
  end
end
