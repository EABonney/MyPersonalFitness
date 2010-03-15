class CreateRoutes < ActiveRecord::Migration
  def self.up
    create_table :routes do |t|
      t.string :name
      t.float :distance_mi
      t.float :distance_km
      t.string :route_type
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :routes
  end
end
