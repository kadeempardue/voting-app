FactoryBot.define do
  factory :vote do
    association :voting_booth, factory: :voting_booth
    association :election, factory: :candidate
    association :voter, factory: :user

    voter_email { voter.email }
    voter_zip_code { voter.zip_code }
  end
end
