# frozen_string_literal: true

class CreatePrograms < ActiveRecord::Migration[7.1]
  def change
    create_table :programs do |t|
      t.string :name, null: false
      t.text :description
      t.text :issue_areas, array: true, default: []
      t.integer :target_funding, default: 0
      t.integer :current_funding, default: 0
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
