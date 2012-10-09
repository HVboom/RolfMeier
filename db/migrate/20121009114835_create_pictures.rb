class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :title
      t.string :image
      t.integer :position
      t.references :gallery

      t.timestamps
    end
    add_index :pictures, :gallery_id
  end
end
