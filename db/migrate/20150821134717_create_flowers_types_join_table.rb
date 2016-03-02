class CreateFlowersTypesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :flowers, :types do |t|
       t.index [:flower_id, :type_id]
       t.index [:type_id, :flower_id]
    end
  end
end
