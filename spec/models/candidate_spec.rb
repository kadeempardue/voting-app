require 'rails_helper'

RSpec.describe Candidate, type: :model do
  subject { build(:candidate) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

    it "#limit_total_candidates" do
      create_list(:candidate, 10)
      expect(subject).to be_invalid
    end
  end

  describe "associations" do
    it { is_expected.to have_many(:votes).dependent(:destroy).class_name("Vote").with_foreign_key("election_id") }
  end
end
