# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :description
      t.text :notes
      t.integer :department
      t.string :category
      t.integer :hours
      t.datetime :internal_deadline
      t.datetime :client_deadline
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
