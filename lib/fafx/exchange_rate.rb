# frozen_string_literal: true

module Fafx
  module ExchangeRate
    def get(base, other)
      validate_currency_args!(base, other)
      core = Core.default
      core.rate(other) / core.rate(base)
    end

    def at(date, base, other)
      validate_currency_args!(base, other)
      date = DateHandler.get(date)
      core = Core.default
      base = core.rates_at(date, base)
      other = core.rates_at(date, other)
      other / base
    end

    def currencies_available
      Core.default.currencies
    end

    def dates_available
      Core.default.dates
    end

    def most_recent
      ex_rates = Core.default
      first_date = ex_rates.dates.first
      ex_rates.rates[first_date]
    end

    def update_data
      DataFetcher.save_to_disk
      Core.reset!
    end

    def validate_currency_args!(*args)
      args.each do |arg|
        raise CurrencyError, 'Currency must be a non-empty string' if arg.nil? || !arg.is_a?(String) || arg.empty?
      end
    end

    module_function :get,
                    :at,
                    :currencies_available,
                    :dates_available,
                    :most_recent,
                    :update_data,
                    :validate_currency_args!
  end
end
