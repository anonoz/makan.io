class RenameJenisToKindInFoodOptions < ActiveRecord::Migration
  def change
    rename_column :food_options, :jenis, :kind
  end
end
