# frozen_string_literal: true

def seed(file)
  load Rails.root.join('db', 'seeds', "#{file}.rb")
  p "Seeded #{file}"
end

puts "Seeding #{Rails.env} database..."
seed 'admin'
seed 'users'
seed 'organizations'
seed 'clients'
seed 'tasks'

puts 'All files successfully seeded'
