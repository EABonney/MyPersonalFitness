class CreateRoutePoints < ActiveRecord::Migration
  def self.up
    create_table :route_points do |t|
      t.decimal :lat, :precision => 15, :scale => 10
      t.decimal :lng, :precision => 15, :scale => 10
      t.integer :route_id

      t.timestamps
    end
  end

  def self.down
    drop_table :route_points
  end
end
