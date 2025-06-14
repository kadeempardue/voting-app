class Candidate < ApplicationRecord
  MAX_CANDIDATES = 10
  
  has_many :votes, dependent: :destroy, class_name: "Vote", foreign_key: "election_id"

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  before_validation :set_genre

  validate :limit_total_candidates, on: :create

  def limit_total_candidates
    if Candidate.count >= MAX_CANDIDATES
      errors.add(:base, "Maximum number of candidates (10) reached")
    end
  end

  def set_genre
    self.genre = Faker::Music.genre if self.genre.blank?
  end
end
