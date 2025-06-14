class VotesController < ApplicationController
  before_action :redirect_if_not_logged_in, only: [:create]
  before_action :redirect_if_already_voted, only: [:create]
  before_action :reset_if_active_voter_expired, only: [:create]

  def index
    @candidates = ActiveModelSerializers::SerializableResource.new(Candidate.includes(:votes).all, include_votes: true)
  end

  def create
    if @vote = VoteCreateService.new(current_user, vote_params).call
      flash[:notice] = "Vote cast successfully"
      render json: { success: true }, status: :ok
    else
      flash[:alert] = "Could not cast vote. Please try again."
      render json: { success: false }, status: :unprocessable_entity
    end
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
