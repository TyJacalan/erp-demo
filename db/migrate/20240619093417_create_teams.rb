class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.references :user, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
    end
  end
end
