class RenameImageColumn < ActiveRecord::Migration
  def change
    rename_column :ads, :image, :ad_image
  end
end
