# frozen_string_literal: true

u = User.create!(
  full_name: 'Example User',
  email: 'example@example.com',
  password: 'password123!',
  confirmed_at: Time.now,
  position: :development_associate,
  salary: 25_000
)

u.skip_invitation
