class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true
      t.decimal :total, precision: 7, scale: 3, default: 6.0, null: false

      t.timestamps null: false
    end
    add_foreign_key :orders, :users
  end
end
