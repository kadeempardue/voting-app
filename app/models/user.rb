class User < ApplicationRecord
  has_many :nominations, dependent: :destroy
  has_many :votes, dependent: :destroy, class_name: "Vote", foreign_key: "voter_id"
  has_many :candidates, through: :nominations, class_name: "Candidate", foreign_key: "candidate_id"
  
  belongs_to :role

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :zip_code, presence: true, format: { with: /\A\d{5}\z/ }

  has_secure_password

  before_validation :set_role

  def set_role
    self.role = Role.find_by(key: "attendee") if self.role.nil?
  end

  def voted?
    votes.any?
  end
end
