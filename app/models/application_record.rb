# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def active_record_errors
    errors&.messages&.map { |_key, value| value }&.map { |error, _temp| error }
  end
end
