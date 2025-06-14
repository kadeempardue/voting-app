require 'rails_helper'

RSpec.describe VotingBooth, type: :model do
  subject { build(:voting_booth) }

  describe "validations" do
    it { is_expected.to validate_inclusion_of(:in_use).in_array([true, false]) }
  end

  describe "#active_voter" do
    describe "in use" do
      subject { build(:voting_booth, :in_use) }

      it "returns the active voter" do
        subject.active_voter_id = create(:user).id
        expect(subject.active_voter).to eq(subject.active_voter)
      end
    end

    describe "not in use" do
      it "returns nil" do
        expect(subject.active_voter).to be_nil
      end
    end
  end
end
