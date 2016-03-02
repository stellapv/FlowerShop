class AddDropdownToTypes < ActiveRecord::Migration
  def change
    add_column :types, :dropdown, :string
  end
end
