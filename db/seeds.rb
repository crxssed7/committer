# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Entry.destroy_all
Repository.destroy_all

tms = Repository.create!(
  name: "themetalstore-rails"
)

expo = Repository.create!(
  name: "exposure-2"
)

entry1 = Entry.create!(
  repository: tms,
  ticket_number: 1444,
  start_time: Time.current.beginning_of_hour,
  end_time: Time.current.beginning_of_hour + 1.hour,
  description: "I did some work"
)

entry2 = Entry.create!(
  repository: tms,
  ticket_number: 1444,
  start_time: Time.current.beginning_of_hour + 1.hour,
  end_time: Time.current.beginning_of_hour + 4.hour,
  description: "Worked on committer"
)

Entry.create!(
  start_time: entry2.end_time,
  description: "I did alot of work"
)
