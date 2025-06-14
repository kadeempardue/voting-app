class VoteCreateService
  attr_reader :vote_params

  def initialize(user, vote_params)
    @user = user
    @vote_params = vote_params
    @vote = Vote.new
    @voting_booth = VotingBooth.first
  end

  def call
    return false if unauthorized_write_in?

    @vote.voter = @user
    @vote.voter_email = @user.email
    @vote.voter_zip_code = @user.zip_code
    @vote.voting_booth = @voting_booth
    @vote.assign_attributes(vote_params) # Assigns candidate or write-in
    saved = @vote.save
    @voting_booth.reset_active_voter if saved
    saved
  end

  private

  def unauthorized_write_in?
    return false if vote_params[:election_attributes]&.[](:name).blank?
    vote_params[:election_attributes][:name].downcase.match("mcvoterson")
  end
end