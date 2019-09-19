# frozen_string_literal: true

class Collector < ApplicationRecord
  scope :by_uuid, (->(uuid) { where(uuid: uuid) })

  after_initialize :set_uuid

  validates :email, email: true
  validates :uuid, :email, uniqueness: true
  validates :name, :email, :uuid, presence: true

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
