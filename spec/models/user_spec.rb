# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar_url             :string
#  birthdate              :date
#  client_manager         :boolean          default(FALSE)
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
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
#  mobile                 :string
#  moderator              :boolean          default(FALSE)
#  position               :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  salary                 :float
#  sign_in_count          :integer          default(0), not null
#  task_manager           :boolean          default(FALSE)
#  team                   :string
#  team_manager           :boolean          default(FALSE)
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :bigint
#  location_id            :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by            (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_location_id           (location_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'role assignment' do
    let(:development_associate_user) { users(:development_associate_user) }
    let(:senior_development_associate_user) { users(:senior_development_associate_user) }
    let(:associate_development_manager_user) { users(:associate_development_manager_user) }
    let(:editor_user) { users(:editor_user) }
    let(:people_partnership_associate_user) { users(:people_partnership_associate_user) }

    it 'assigns roles correctly' do
      senior_development_associate_user.save
      editor_user.save
      associate_development_manager_user.save
      people_partnership_associate_user.save

      expect(development_associate_user.task_manager).to be false
      expect(senior_development_associate_user.task_manager).to be true
      expect(editor_user.team_manager).to be true
      expect(associate_development_manager_user.client_manager).to be true
      expect(people_partnership_associate_user.moderator).to be true
    end

    it 'assigns multiple roles correctly' do
      associate_development_manager_user.save
      expect(associate_development_manager_user.client_manager).to be true
      expect(associate_development_manager_user.team_manager).to be true
      expect(associate_development_manager_user.moderator).to be false
    end
  end
end
