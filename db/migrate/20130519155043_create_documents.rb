class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.string :file
      t.references :page

      t.timestamps
    end
    add_index :documents, :page_id
  end
end
