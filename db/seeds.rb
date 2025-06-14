# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

attendee_role = Role.create!(name: "Attendee", key: "attendee")

User.create!([
  {email: "attendee@example.com", password: "password", role: attendee_role, zip_code: "12345"},
  {email: "fan@example.com", password: "password", role: attendee_role, zip_code: "12345"}
])

VotingBooth.create!

# Testing purposes only
# Candidate.create!([
#   {name: "John Doe", genre: "Rock"},
#   {name: "Jane Smith", genre: "Pop"},
#   {name: "Jim Beam", genre: "Country"},
#   {name: "Jill Johnson", genre: "Hip Hop"},
#   {name: "Jack Daniels", genre: "Jazz"},
# ])
