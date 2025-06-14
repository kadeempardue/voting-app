# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2025_06_13_144449) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidates", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "zip_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "voting_booth_id", null: false
    t.bigint "election_id", null: false
    t.bigint "voter_id", null: false
    t.string "voter_email", null: false
    t.string "voter_zip_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["election_id"], name: "index_votes_on_election_id"
    t.index ["voter_id"], name: "index_votes_on_voter_id"
    t.index ["voting_booth_id", "election_id", "voter_id"], name: "unique_vote_per_voter_per_election", unique: true
    t.index ["voting_booth_id"], name: "index_votes_on_voting_booth_id"
  end

  create_table "voting_booths", force: :cascade do |t|
    t.boolean "in_use", default: false, null: false
    t.integer "active_voter_id"
    t.datetime "active_voter_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active_voter_id"], name: "index_voting_booths_on_active_voter_id"
  end

  add_foreign_key "votes", "candidates", column: "election_id"
  add_foreign_key "votes", "users", column: "voter_id"
end
