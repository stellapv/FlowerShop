class AddUnitPriceToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :unit_price, :decimal, precision: 7, scale: 3
  end
end
