# frozen_string_literal: true

class DatetimeUtil
  class << self
    def convert_to_miliseconds(datetime)
      return if datetime.nil? || !(datetime.is_a? DateTime)

      datetime.strftime('%Q').to_i
    end
  end
end
