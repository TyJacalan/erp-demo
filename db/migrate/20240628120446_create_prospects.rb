# frozen_string_literal: true

class CreateProspects < ActiveRecord::Migration[7.1]
  def change
    create_table :prospects do |t|
      t.references :organization, null: false, foreign_key: true
      t.text :vision
      t.string :facebook
      t.string :linkedin
      t.string :instagram
      t.string :youtube
      t.string :founder
      t.string :founding_year
      t.text :history
      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.references :updated_by, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
