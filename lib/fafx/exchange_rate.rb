module Fafx
  module ExchangeRate
    def at(date, base, other)
      ex_rates = ER.new
      base = ex_rates.rates_at(date.to_s, base)
      other = ex_rates.rates_at(date.to_s, other)
      other / base
    end

    def currencies_available
      ER.new.currencies
    end

    def dates_available
      ER.new.dates
    end

    def most_recent
      ex_rates = ER.new
      first_date = ex_rates.dates.first
      ex_rates.rates[first_date]
    end

    def fetch_data_and_save_to_disk
      DataFetcher.save_to_disk
    end
    module_function :at,
                    :currencies_available,
                    :dates_available,
                    :most_recent,
                    :fetch_data_and_save_to_disk
  end
end
