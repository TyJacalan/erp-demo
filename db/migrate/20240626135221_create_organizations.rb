# frozen_string_literal: true

class CreateOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :website
      t.text :mission
      t.integer :organization_type, null: false, default: 0
      t.references :location, null: true, foreign_key: true

      t.timestamps
    end

    create_table :offices do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
