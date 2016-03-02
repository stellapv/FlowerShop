class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user, index: true
      t.string :token

      t.timestamps null: false
    end
    add_foreign_key :sessions, :users
  end
end
