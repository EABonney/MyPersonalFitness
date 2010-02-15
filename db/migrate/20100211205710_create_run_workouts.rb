class CreateRunWorkouts < ActiveRecord::Migration
  def self.up
    create_table :run_workouts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :run_workouts
  end
end
