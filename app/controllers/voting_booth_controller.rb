class VotingBoothController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :redirect_if_already_voted
  before_action :reset_if_active_voter_expired, only: [:index]

  def index
    @candidates = Candidate.all
    VotingBoothService.new.enter_booth!(current_user)
  rescue VotingBoothService::BoothInUseError
    redirect_to root_path, alert: "Voting booth is currently in use: #{@voting_booth.time_remaining} seconds remaining"
  end

  private
  
  def reset_if_active_voter_expired
    @voting_booth.reset_active_voter if @voting_booth.active_voter_expired?
  end

  def redirect_if_already_voted
    if current_user.voted?
      redirect_to root_path, alert: "You have already voted"
    end
  end
end
