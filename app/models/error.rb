# frozen_string_literal: true

class Error
  attr_reader :messages

  def initialize
    @messages = []
  end

  def add(attribute, options = {})
    @messages << I18n.t(attribute, options)
    self
  end

  def add_all_messages(errors)
    @messages += errors
    self
  end

  def empty?
    @messages.empty?
  end
end
