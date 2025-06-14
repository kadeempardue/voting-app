class Vote < ApplicationRecord
  belongs_to :voter, class_name: "User", foreign_key: "voter_id"
  belongs_to :election, class_name: "Candidate", foreign_key: "election_id"
  belongs_to :voting_booth

  validates :voter_id, presence: true
  validates :election_id, presence: true, if: -> { election&.persisted? }
  validates :voting_booth_id, presence: true

  validates :voter_id, uniqueness: true

  accepts_nested_attributes_for :election
end