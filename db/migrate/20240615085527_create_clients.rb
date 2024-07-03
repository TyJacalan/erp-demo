# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :abbreviation
      t.integer :status,           null: false, default: 0
      t.text :issue_areas,         array: true, default: []

      t.timestamps
    end
  end
end
