FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@example.com" }

  factory :position do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    email { generate(:email) }
    is_treasure false
  end

  factory :treasure_position, class: Position do
    latitude 50.051227
    longitude 19.945704
    email { generate(:email) }
    is_treasure true
  end
end
