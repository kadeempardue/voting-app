class VoteSerializer < ActiveModel::Serializer
  attributes :id, :voting_booth_id, :voter_id, :voter_email, :voter_zip_code, :created_at, :updated_at

  belongs_to :voter, serializer: UserSerializer, include_voter: true
  belongs_to :election, serializer: CandidateSerializer, include_election: true
end
