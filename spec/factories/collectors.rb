# frozen_string_literal: true

FactoryBot.define do
  factory :collector, class: Collector do
    name { Faker::Name.name }
    email { Faker::Internet.email }

    initialize_with { new(attributes) }
  end

  factory :collector_without_name, class: Collector do
    email { Faker::Internet.email }

    initialize_with { new(attributes) }
  end

  factory :collector_without_email, class: Collector do
    name { Faker::Name.name }

    initialize_with { new(attributes) }
  end

  factory :collector_with_invalid_email, class: Collector do
    name { Faker::Name.name }
    email { 'invalid_email' }

    initialize_with { new(attributes) }
  end
end
