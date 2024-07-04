# frozen_string_literal: true

User.find_or_create_by(email: 'clientmanager@example.com') do |user|
  user.full_name = 'Client Manager'
  user.password = 'password123!'
  user.position = :associate_development_manager
  user.team = 'Corgis'
  user.skip_invitation
end

User.find_or_create_by(email: 'taskmanager@example.com') do |user|
  user.full_name = 'Task Manager'
  user.password = 'password123!'
  user.position = :senior_development_associate
  user.team = 'Bongos'
  user.skip_invitation
end

User.find_or_create_by(email: 'teammanager@example.com') do |user|
  user.full_name = 'Team Manager'
  user.password = 'password123!'
  user.position = :associate_development_manager
  user.team = 'Armadillos'
  user.skip_invitation
end

User.find_or_create_by(email: 'freelancer@example.com') do |user|
  user.full_name = 'Freelancer User'
  user.password = 'password123!'
  user.position = :freelancer
  user.team = 'Bongos'
  user.skip_invitation
end

User.find_or_create_by(email: 'director@example.com') do |user|
  user.full_name = 'Freelancer User'
  user.password = 'password123!'
  user.position = :director
  user.team = 'Tarsiers'
  user.skip_invitation
end
