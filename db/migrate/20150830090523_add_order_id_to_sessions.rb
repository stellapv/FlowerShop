class AddOrderIdToSessions < ActiveRecord::Migration
  def change
    add_reference :sessions, :order, index: true
    add_foreign_key :sessions, :orders
  end
end
