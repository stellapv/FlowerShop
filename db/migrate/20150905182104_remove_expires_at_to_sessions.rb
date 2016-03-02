class RemoveExpiresAtToSessions < ActiveRecord::Migration
  def change
    remove_column :sessions, :expires_at, :datetime
  end
end
