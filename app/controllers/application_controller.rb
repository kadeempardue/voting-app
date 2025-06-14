class ApplicationController < ActionController::Base
  include Authenticable

  before_action :set_voting_booth

  def set_voting_booth
    @voting_booth = VotingBooth.first
  end
end
