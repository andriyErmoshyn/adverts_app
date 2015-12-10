class ChangeContentName < ActiveRecord::Migration
  def change
    rename_column :ads, :content, :ad_content
  end
end
