class VotesController < ApplicationController
  before_action :redirect_if_not_logged_in, only: [:create]
  before_action :redirect_if_already_voted, only: [:create]
  before_action :reset_if_active_voter_expired, only: [:create]

  def index
    @candidates = ActiveModelSerializers::SerializableResource.new(Candidate.includes(:votes).all, include_votes: true)
  end

  def create
    @vote = VotingBoothService.cast_vote!(current_user, vote_params)
    flash[:notice] = "Vote cast successfully"
    render json: { success: true }, status: :ok
  rescue VotingBoothService::BoothInUseError
    flash[:alert] = "Could not cast vote. Please try again."
    render json: { success: false }, status: :unprocessable_entity
  rescue VotingBoothService::UnauthorizedWriteInError
    flash[:alert] = "Vote cast window expired. Please try again."
    render json: { success: false }, status: :unprocessable_entity
  end

  private

  def vote_params
    params.require(:vote).permit(:election_id, election_attributes: %i[name])
  end

  def reset_if_active_voter_expired
    @voting_booth.reset_active_voter if @voting_booth&.active_voter_expired?
  end

  def redirect_if_already_voted
    if current_user.voted?
      redirect_to root_path, alert: "You have already voted"
    end
  end
end
