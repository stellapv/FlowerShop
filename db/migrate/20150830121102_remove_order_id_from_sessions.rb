class RemoveOrderIdFromSessions < ActiveRecord::Migration
   def change
    remove_foreign_key :sessions, :orders
    remove_reference :sessions, :order, index: true
  end
end
