module DateHandler
  def get(date)
    raise Fafx::DateError, 'Not a valid Date object' unless date.class == Date
    handle_weekend(date).to_s
  end

  private

  def handle_weekend(date)
    case date.wday
    when 6 # Saturday
      date -= 1
    when 0 # Sunday
      date -= 2
    end
    date
  end

  module_function :get, :handle_weekend
end
