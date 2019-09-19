# frozen_string_literal: true

class ApplicationSerializer < ActiveModel::Serializer
  attribute :uuid, key: :id
  attributes :created_at, :updated_at

  def created_at
    DatetimeUtil.convert_to_miliseconds(object.created_at.to_datetime)
  end

  def updated_at
    DatetimeUtil.convert_to_miliseconds(object.updated_at.to_datetime)
  end
end
