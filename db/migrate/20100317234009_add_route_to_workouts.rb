class AddRouteToWorkouts < ActiveRecord::Migration
  def self.up
    add_column :workouts, :route_id, :integer, :null => true
  end

  def self.down
    remove_column :workouts, :route_id
  end
end
