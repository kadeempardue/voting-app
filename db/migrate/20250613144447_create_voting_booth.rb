class CreateVotingBooth < ActiveRecord::Migration[7.0]
  def change
    create_table :voting_booths do |t|
      t.boolean :in_use, null: false, default: false
      t.integer :active_voter_id
      t.datetime :active_voter_expires_at
      
      t.index :active_voter_id
      t.timestamps
    end
  end
end
