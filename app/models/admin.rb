# frozen_string_literal: true

# == Schema Information
#
# Table name: admins
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  full_name              :string           default(""), not null
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :bigint
#
# Indexes
#
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_invitation_token      (invitation_token) UNIQUE
#  index_admins_on_invited_by            (invited_by_type,invited_by_id)
#  index_admins_on_invited_by_id         (invited_by_id)
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#  index_admins_on_unlock_token          (unlock_token) UNIQUE
#
class Admin < ApplicationRecord
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :lockable, :trackable
end
