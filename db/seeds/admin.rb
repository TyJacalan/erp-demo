# frozen_string_literal: true

a = Admin.create!(
  email: 'admin@example.com',
  password: 'password123!',
  confirmed_at: Time.now
)

a.skip_confirmation!
