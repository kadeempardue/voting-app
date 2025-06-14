class CandidateSerializer < ActiveModel::Serializer
  attributes :id, :name
  
  has_many :votes, if: -> { instance_options[:include_votes] }
end
