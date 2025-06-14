class VotingBoothService  
  def initialize
    @voting_booth = VotingBooth.lock.first # row-level DB lock
  end

  def enter_booth!(voter)
    VotingBooth.transaction do
      raise BoothInUseError if @voting_booth.in_use? && @voting_booth.active_voter != voter
      @voting_booth.in_use = true
      @voting_booth.active_voter_id = voter.id
      @voting_booth.active_voter_expires_at = 30.seconds.from_now if @voting_booth.active_voter_expires_at.blank?
      @voting_booth.save!
    end
  end

  def cast_vote_with_lock!(voter, voting_booth)
    VotingBooth.transaction do
      raise BoothInUseError unless @voting_booth.in_use? && @voting_booth.active_voter == voter

      begin
        cast_vote
      ensure
        @voting_booth.update!(in_use: false, active_voter_id: nil, active_voter_expires_at: nil)
      end
    end
  end

  def cast_vote!
    Vote.create!(voter: @voter, election: @candidate, voting_booth: @voting_booth)
  end

  private

  class BoothInUseError < StandardError; end
end