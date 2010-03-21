class AddOtherDescriptionToWorkouts < ActiveRecord::Migration
  def self.up
    add_column :workouts, :description, :string, :null => true
  end

  def self.down
    remove_column :workouts, :description
  end
end
