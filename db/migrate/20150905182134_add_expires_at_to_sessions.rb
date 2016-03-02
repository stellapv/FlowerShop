class AddExpiresAtToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :expires_at, :datetime
  end
end
