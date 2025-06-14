class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.belongs_to :voting_booth, null: false
      t.belongs_to :election, null: false, foreign_key: {to_table: :candidates}
      t.belongs_to :voter, null: false, foreign_key: {to_table: :users}

      # Flattened fields of user for faster display
      t.string :voter_email, null: false
      t.string :voter_zip_code, null: false
  
      t.index [:voting_booth_id, :election_id, :voter_id], unique: true, name: "unique_vote_per_voter_per_election"

      t.timestamps
    end
  end
end
