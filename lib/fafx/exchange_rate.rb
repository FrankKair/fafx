module Fafx
  module ExchangeRate
    def at(date, base, other)
      er = ER.new
      base = er.rates_at(date.to_s, base)
      other = er.rates_at(date.to_s, other)
      other / base
    end

    def currencies_available
      ER.new.currencies
    end

    def dates_available
      ER.new.dates
    end

    def most_recent
      er = ER.new
      k = er.dates.first
      er.rates[k]
    end
    module_function :at, :currencies_available, :dates_available, :most_recent
  end
end
