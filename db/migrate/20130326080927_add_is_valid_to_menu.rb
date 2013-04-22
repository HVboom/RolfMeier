class AddIsValidToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :is_valid, :boolean, :default => 1

    Menu.reset_column_information
    Menu.all.each do |m|
      m.update_attribute :is_valid, true
    end
  end
end
