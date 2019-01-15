module Fafx
  module ExchangeRate
    def at(date, base, other)
      case date.wday
      when 6 # Saturday
        date -= 1
      when 0 # Sunday
        date -= 2
      end

      ex_rates = Core.new
      base = ex_rates.rates_at(date.to_s, base)
      other = ex_rates.rates_at(date.to_s, other)
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
    module_function :at,
                    :currencies_available,
                    :dates_available,
                    :most_recent,
                    :update_data
  end
end
