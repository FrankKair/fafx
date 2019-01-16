module Fafx
  class DateError < StandardError
    attr_reader :message
    def initialize(message)
      super
      @message = message
    end
  end

  class CurrencyError < StandardError
    attr_reader :message
    def initialize(message)
      super
      @message = message
    end
  end
end