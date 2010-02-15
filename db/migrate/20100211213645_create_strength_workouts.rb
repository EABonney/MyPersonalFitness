class CreateStrengthWorkouts < ActiveRecord::Migration
  def self.up
    create_table :strength_workouts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :strength_workouts
  end
end
