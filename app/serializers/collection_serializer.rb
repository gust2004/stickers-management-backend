# frozen_string_literal: true

class CollectionSerializer < ApplicationSerializer
  has_one :album
  has_one :collector

  # attributes :percent_of_completion,
  #            :number_of_used_stickers, :number_of_repeated_stickers,
  #            :number_of_missing_stickers, :created_at, :updated_at
  #
  # has_one :album
  # has_one :collector
  #
  # def percent_of_completion
  #   "#{((object.stickers.used.count.to_f / object.album.number_of_stickers.to_f) * 100).round(2)} %"
  # end
  #
  # def number_of_used_stickers
  #   object.stickers.used.count
  # end
  #
  # def number_of_repeated_stickers
  #   object.stickers.repeated.map(&:number_of_repeated).reduce(0, :+)
  # end
  #
  # def number_of_missing_stickers
  #   object.stickers.missing.count
  # end
  #
  # def created_at
  #   DatetimeUtil.convert_to_miliseconds(object.created_at.to_datetime)
  # end
  #
  # def updated_at
  #   DatetimeUtil.convert_to_miliseconds(object.updated_at.to_datetime)
  # end
end
