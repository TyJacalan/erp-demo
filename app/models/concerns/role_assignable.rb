# frozen_string_literal: true

module RoleAssignable
  extend ActiveSupport::Concern

  included do
    after_save :assign_roles
  end

  ROLES = {
    task_manager: %i[senior_development_associate senior_writer_researcher],
    client_manager: %i[senior_development_associate associate_development_manager development_manager director],
    team_manager: %i[editor associate_development_manager development_manager director vice_president president ceo],
    moderator: %i[people_partnership_associate director vice_president president]
  }.freeze

  def assign_roles
    ROLES.each do |role, positions|
      update_column(role, positions.include?(position.to_sym))
    end
  end
end
