class AddAttachmentFeaturePhotoToFoodMenus < ActiveRecord::Migration
  def self.up
    change_table :food_menus do |t|
      t.attachment :feature_photo
    end
  end

  def self.down
    remove_attachment :food_menus, :feature_photo
  end
end
