require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:zip_code) }
  end

  describe "associations" do
    it { is_expected.to have_many(:votes).dependent(:destroy).class_name("Vote").with_foreign_key("voter_id") }
  end
end
