class CandidateSerializer < ActiveModel::Serializer
  attributes :id, :name, :genre
  
  has_many :votes, if: -> { instance_options[:include_votes] }
end
