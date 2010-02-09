class AddNameAddressUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string, :null => true
    add_column :users, :last_name, :string, :null => true
    add_column :users, :street, :string, :null => true
    add_column :users, :city, :string, :null => true
    add_column :users, :state, :string, :null => true
    add_column :users, :zipcode, :string, :null => true
  end

  def self.down
    remove_column :users, :zipcode
    remove_column :users, :state
    remove_column :users, :city
    remove_column :users, :street
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end
