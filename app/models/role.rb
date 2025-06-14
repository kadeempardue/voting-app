class Role < ApplicationRecord
  has_many :users

  validates :name, presence: true
  validates :key, presence: true, uniqueness: true
end