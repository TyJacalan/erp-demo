# frozen_string_literal: true

a = Admin.create_or_find_by!(email: 'admin@example.com') do |admin|
  admin.password = 'password123!'
end

a.skip_invitation
