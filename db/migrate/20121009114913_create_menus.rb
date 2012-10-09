class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :title
      t.integer :position
      t.references :parent

      t.timestamps
    end
    add_index :menus, :parent_id
  end
end
