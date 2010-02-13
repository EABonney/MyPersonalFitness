class CreateSwimWorkouts < ActiveRecord::Migration
  def self.up
    create_table :swim_workouts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :swim_workouts
  end
end
