class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.references :page

      t.timestamps
    end
    add_index :galleries, :page_id
  end
end
