class VotingBoothService  
  class << self
    def enter_booth!(voter)
      VotingBooth.transaction do
        @voting_booth = VotingBooth.lock.first # row-level DB lock

        @voting_booth.reset_active_voter if @voting_booth&.active_voter_expired?
        raise BoothInUseError if @voting_booth.occupied? && @voting_booth.active_voter_id != voter.id
        @voting_booth.in_use = true
        @voting_booth.active_voter_id = voter.id if @voting_booth.active_voter_id.blank?
        @voting_booth.active_voter_expires_at = 30.seconds.from_now if @voting_booth.active_voter_expires_at.blank?
        @voting_booth.save!
      end
    end
  
    def cast_vote!(voter, vote_params)
      Vote.transaction do
        @voting_booth = VotingBooth.lock.first # row-level DB lock
        raise BoothInUseError unless @voting_booth.occupied? && @voting_booth.active_voter_id == voter.id
        
        raise UnauthorizedWriteInError if unauthorized_write_in?(vote_params[:election_attributes]&.[](:name))
  
        @vote = Vote.new
        @vote.voter = voter
        @vote.voter_email = voter.email
        @vote.voter_zip_code = voter.zip_code
        @vote.voting_booth = @voting_booth
        @vote.assign_attributes(vote_params) # Assigns candidate or write-in
        saved = @vote.save!
    
        @voting_booth.reset_active_voter if saved
        saved
      end
    end

    def unauthorized_write_in?(name)
      return false if name.blank?
      name.downcase.match("mcvoterson")
    end
  end

  private

  class BoothInUseError < StandardError; end
  class UnauthorizedWriteInError < StandardError; end
end