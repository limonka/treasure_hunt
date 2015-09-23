FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@example.com" }
  sequence(:latitude) { |n| 50.051227 * n  }
  sequence(:longitude) { |n| 19.945704 * n }

  factory :position do
    latitude { generate(:latitude) }
    longitude { generate(:longitude) }
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
