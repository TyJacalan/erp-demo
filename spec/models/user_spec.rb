# frozen_string_literal: true

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
