class ChangeEmailAndPasswordInSubvendorsToBeOptional < ActiveRecord::Migration
  def up
    change_column :vendor_subvendors, :email, :string, null: true
    change_column :vendor_subvendors, :encrypted_password, :string, null: true
  end

  def down
  	change_column :vendor_subvendors, :email, :string, null: false
  	change_column :vendor_subvendors, :encrypted_password, :string, null: false
  end
end
