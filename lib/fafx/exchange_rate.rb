module Fafx
  module ExchangeRate
    # TODO: Error handling - begin / rescue?
    # Check date, currency existance
    def at(date, base, other)
      rates = ER.new.rates
      rates[date.to_s]["#{other}"] / rates[date.to_s]["#{base}"]
    end

    module_function :at
  end
end
