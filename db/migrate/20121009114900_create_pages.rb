class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :slug
      t.text :short_text
      t.text :long_text
      t.string :maintainer
      t.string :content_type
      t.text :content
      t.references :menu

      t.timestamps
    end
    add_index :pages, :menu_id
  end
end
