class VotingBooth < ApplicationRecord
  validates :in_use, inclusion: { in: [true, false] }

  def active_voter
    return nil if active_voter_id.blank?
    @active_voter ||= User.find(active_voter_id)
  end

  def active_voter_expired?
    return true if active_voter_expires_at.blank?
    active_voter_expires_at < Time.current
  end

  def occupied?
    in_use? && active_voter_id.present? && !active_voter_expired?
  end

  def reset_active_voter
    self.active_voter_id = nil
    self.active_voter_expires_at = nil
    self.in_use = false
    self.save
  end

  def time_remaining
    return 0 if active_voter_expires_at.blank?
    (active_voter_expires_at - Time.current).to_i
  end
end