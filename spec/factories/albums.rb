# frozen_string_literal: true

FactoryBot.define do
  factory :album, class: Album do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    number_of_stickers { Faker::Number.number(digits: 3) }

    initialize_with { new(attributes) }
  end

  factory :album_without_name, class: Album do
    description { Faker::Lorem.sentence }
    number_of_stickers { Faker::Number.number(digits: 3) }

    initialize_with { new(attributes) }
  end

  factory :album_without_number_of_stickers, class: Album do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }

    initialize_with { new(attributes) }
  end
end
