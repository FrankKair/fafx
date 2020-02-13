module Fafx
  module ExchangeRate
    def get(base, other)
      core = Core.new
      core.rate(other) / core.rate(base)
    end

    def at(date, base, other)
      date = DateHandler.get(date)
      ex_rates = Core.new
      base = ex_rates.rates_at(date, base)
      other = ex_rates.rates_at(date, other)
      other / base
    end

    def currencies_available
      Core.new.currencies
    end

    def dates_available
      Core.new.dates
    end

    def most_recent
      ex_rates = Core.new
      first_date = ex_rates.dates.first
      ex_rates.rates[first_date]
    end

    def update_data
      DataFetcher.save_to_disk
    end
    module_function :get,
                    :at,
                    :currencies_available,
                    :dates_available,
                    :most_recent,
                    :update_data
  end
end
