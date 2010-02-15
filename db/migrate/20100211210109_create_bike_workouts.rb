class CreateBikeWorkouts < ActiveRecord::Migration
  def self.up
    create_table :bike_workouts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :bike_workouts
  end
end
