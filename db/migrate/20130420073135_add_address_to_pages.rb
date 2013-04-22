class AddAddressToPages < ActiveRecord::Migration
  def change
    add_column :pages, :address, :string
    add_column :pages, :latitude, :float
    add_column :pages, :longitude, :float
  end
end
