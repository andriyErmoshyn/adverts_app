class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :content
      t.string :image
      t.references :member, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :ads, :created_at
  end  
end
