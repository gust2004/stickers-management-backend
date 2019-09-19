# frozen_string_literal: true

FactoryBot.define do
  factory :collection do
    collector { create(:collector) }
    album { create(:album) }

    initialize_with { new(attributes) }
  end
end
