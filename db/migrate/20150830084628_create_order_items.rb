class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order, index: true
      t.references :flower, index: true
      t.integer :quantity
      t.decimal :subtotal, precision: 7, scale: 4

      t.timestamps null: false
    end
    add_foreign_key :order_items, :orders
    add_foreign_key :order_items, :flowers
  end
end
