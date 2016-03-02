class AddAttachmentFlowerPhotoToFlowers < ActiveRecord::Migration
  def self.up
    change_table :flowers do |t|
      t.attachment :flower_photo
    end
  end

  def self.down
    remove_attachment :flowers, :flower_photo
  end
end
