# frozen_string_literal: true

class CreateContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :contracts do |t|
      t.references :client, null: false, foreign_key: true
      t.float :monthly_fee
      t.date :start_date
      t.date :end_date
      t.integer :service_type

      t.timestamps
    end
  end
end
