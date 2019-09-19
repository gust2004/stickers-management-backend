# frozen_string_literal: true

class Sticker < ApplicationRecord
  belongs_to :collection

  scope :by_uuid, (->(uuid) { where(uuid: uuid) })
  scope :by_collection, (->(collection) { where('collection_id=?', collection.id).order(:number) })
  scope :missing, (-> { where('quantity = ?', 0).order(:number) })
  scope :used, (-> { where('quantity = ?', 1).order(:number) })
  scope :repeated, (-> { where('quantity > ?', 1).order(:number) })

  after_initialize :set_uuid

  validates :uuid, uniqueness: true
  validates :number, :quantity, :uuid, presence: true

  STATUS = [REPEATED = 'REPEATED', USED = 'USED', MISSING = 'MISSING'].freeze

  def status
    if quantity.zero?
      Sticker::MISSING
    elsif quantity == 1
      Sticker::USED
    else
      Sticker::REPEATED
    end
  end

  def number_of_repeated
    return quantity - 1 if quantity > 1

    0
  end

  def set_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
