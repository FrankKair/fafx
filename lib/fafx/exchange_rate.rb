module Fafx
  module ExchangeRate
    def at(date, base, other)
      er = ER.new
      base = er.rates_at(date.to_s, base)
      other = er.rates_at(date.to_s, other)
      other / base
    end
    module_function :at
  end
end
