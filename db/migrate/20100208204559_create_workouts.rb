class CreateWorkouts < ActiveRecord::Migration
  def self.up
    create_table :workouts do |t|
      t.string :workout_date
      t.string :time_of_day
      t.string :duration
      t.integer :distance
      t.integer :user_id
      t.string :type
      t.text :notes,            :nil => true
      t.string :plan_type
      t.integer :min_hr,        :default => 0
      t.integer :avg_hr,        :default => 0
      t.integer :max_hr,        :default => 0
      t.integer :cals_burned,   :default => 0
      t.integer :pace,          :nil => true
      t.integer :avg_rpms,      :default => 0
      t.integer :distance,      :nil => true

      t.timestamps
    end
  end

  def self.down
    drop_table :workouts
  end
end
