class User < ApplicationRecord
  has_many :votes, dependent: :destroy, class_name: "Vote", foreign_key: "voter_id"
  
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :zip_code, presence: true, format: { with: /\A\d{5}\z/ }

  has_secure_password

  def voted?
    votes.any?
  end
end
