# frozen_string_literal: true

class Collection < ApplicationRecord
  belongs_to :album
  belongs_to :collector
  has_many :stickers, dependent: :destroy

  scope :by_uuid, (->(uuid) { where(uuid: uuid) })
  scope :by_collector, (->(collector) { where('collector_id=?', collector.id) })

  after_initialize :set_uuid

  validates :uuid, uniqueness: true
  validates :uuid, presence: true

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
