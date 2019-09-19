# frozen_string_literal: true

FactoryBot.define do
  factory :sticker, class: Sticker do
    collection { create(:collection) }
    number { 1 }
    quantity { 10 }

    initialize_with { new(attributes) }
  end

  factory :sticker_without_number, class: Sticker do
    collection { create(:collection) }
    quantity { 10 }

    initialize_with { new(attributes) }
  end
end
