class CreateMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :memberable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
