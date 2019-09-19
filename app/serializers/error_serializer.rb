# frozen_string_literal: true

module ErrorSerializer
  EMPTY_STRING = ''

  class << self
    def serialize(errors)
      result = errors.empty? ? [] : build(errors)
      { errors: result }.compact
    end

    private

    def build(errors)
      errors.messages.compact.reject(&:empty?).map do |k|
        pos = k.index('-')
        code = pos.present? ? k[0..pos - 2] : EMPTY_STRING
        detail = pos.present? ? k[pos + 2..-1] : k
        [code: code, detail: detail]
      end.flatten
    end
  end
end
