FactoryBot.define do
  factory :candidate do
    name { Faker::Name.unique.name }
  end
end
