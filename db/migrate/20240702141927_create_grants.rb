# frozen_string_literal: true

class CreateGrants < ActiveRecord::Migration[7.1]
  def change
    create_table :grants do |t|
      t.text :recipient_name
      t.text :description
      t.integer :purpose, default: 0
      t.integer :amount, default: 0
      t.string :year, default: 'Undisclosed'
      t.integer :grant_type, default: 0
      t.integer :duration
      t.references :organization, null: false, foreign_key: true
      t.references :recipient, null: true, foreign_key: { to_table: :organizations }
      t.references :program, foreign_key: true

      t.timestamps
    end
  end
end
