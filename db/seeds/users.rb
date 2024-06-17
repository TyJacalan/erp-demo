# frozen_string_literal: true

# Create Sample User
user = User.create_or_find_by!(email: 'example@example.com') do |user|
  user.full_name = 'Example User'
  user.password = 'password123!'
  user.position = :director
  user.skip_invitation
end

# Create Users for each position
%i[
  freelancer
  development_associate
  writer_researcher
  senior_development_associate
  senior_writer_researcher
  editor
  associate_development_manager
  development_manager
  director
  vice_president
  president
  ceo
  people_partnership_associate
].each do |position|
  puts "seeding #{position}"
  User.create_or_find_by!(email: "#{position}@smartergood.com") do |user|
    user.full_name = position.to_s
    user.password = 'password123!'
    user.position = position
    user.team = %i[armadillos bongos capybaras corgis tarsiers].sample
    user.salary = 25_000
    user.skip_invitation
  end
end
