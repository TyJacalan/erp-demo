# frozen_string_literal: true

a = Admin.new(full_name: 'Admin User', email: 'admin@example.com', password: 'password123!')
a.skip_invitation
a.save
