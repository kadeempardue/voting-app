FactoryBot.define do
  factory :voting_booth do
    trait :in_use do
      in_use { true }
      active_voter_id { create(:user).id }
      active_voter_expires_at { 30.seconds.from_now }
    end
  end
end
