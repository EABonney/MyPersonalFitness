class CreateWorkouts < ActiveRecord::Migration
  def self.up
    create_table :workouts do |t|
      t.date :workout_date
      t.time :time_of_day
      t.time :duration
      t.float :distance
      t.integer :user_id
      t.string :type
      t.text :notes,            :nil => true
      t.string :plan_type
      t.integer :min_hr,        :default => 0
      t.integer :avg_hr,        :default => 0
      t.integer :max_hr,        :default => 0
      t.integer :cals_burned,   :default => 0
      t.float :pace,          :nil => true
      t.float :avg_rpms,      :default => 0
      t.float :distance,      :nil => true

      t.timestamps
    end
  end

  def self.down
    drop_table :workouts
  end
end
