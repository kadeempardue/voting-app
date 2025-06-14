require 'rails_helper'

RSpec.describe Vote, type: :model do
  subject { build(:vote) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:voting_booth_id) }
    it { is_expected.to validate_uniqueness_of(:voter_id) }

    it "validates the presence of election_id if election is present" do
      subject.election = nil
      expect(subject).to be_invalid
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:voting_booth) }
    it { is_expected.to belong_to(:election).class_name("Candidate").with_foreign_key("election_id") }
    it { is_expected.to belong_to(:voter).class_name("User").with_foreign_key("voter_id") }
  end

  describe "nested attributes" do
    it { is_expected.to accept_nested_attributes_for(:election) }
  end
end
