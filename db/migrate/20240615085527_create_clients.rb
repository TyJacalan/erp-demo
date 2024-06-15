# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :abbreviation
      t.text :mission

      t.timestamps
    end
  end
end
