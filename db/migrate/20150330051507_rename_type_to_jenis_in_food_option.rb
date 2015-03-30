##
# Coz type is reserved keyword thats why

class RenameTypeToJenisInFoodOption < ActiveRecord::Migration
  def change
    rename_column :food_options, :type, :jenis
  end
end
