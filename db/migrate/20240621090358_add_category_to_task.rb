# frozen_string_literal: true

class AddCategoryToTask < ActiveRecord::Migration[7.1]
  def change
    add_reference :tasks, :task_category, null: false, foreign_key: true
  end
end
