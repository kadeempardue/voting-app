class Candidate < ApplicationRecord
  MAX_CANDIDATES = 10
  
  has_many :votes, dependent: :destroy, class_name: "Vote", foreign_key: "election_id"

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  validate :limit_total_candidates, on: :create

  def limit_total_candidates
    if Candidate.count >= MAX_CANDIDATES
      errors.add(:base, "Maximum number of candidates (10) reached")
    end
  end
end
