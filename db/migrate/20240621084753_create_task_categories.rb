# frozen_string_literal: true

class CreateTaskCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :task_categories do |t|
      t.string :department
      t.string :name

      t.timestamps
    end
  end
end
