# frozen_string_literal: true

class AddOrganizationToClients < ActiveRecord::Migration[7.1]
  def change
    add_reference :clients, :organization, null: false, foreign_key: true
  end
end
