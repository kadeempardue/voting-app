class ApplicationController < ActionController::Base
  include Authenticable

  before_action :set_voting_booth

  def set_voting_booth
    @voting_booth = VotingBooth.first
    @voting_booth.reset_active_voter if @voting_booth&.active_voter_expired?
  end
end
