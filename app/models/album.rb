# frozen_string_literal: true

class Album < ApplicationRecord
  scope :by_uuid, (->(uuid) { where(uuid: uuid) })

  after_initialize :set_uuid

  validates :name, :uuid, uniqueness: true
  validates :name, :number_of_stickers, :uuid, presence: true

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
