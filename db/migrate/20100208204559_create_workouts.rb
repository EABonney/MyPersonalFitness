class CreateWorkouts < ActiveRecord::Migration
  def self.up
    create_table :workouts do |t|
      t.string :workout_date
      t.string :time_of_day
      t.string :duration
      t.integer :user_id
      t.string :type
      t.text :notes
      t.string :play_type
      t.integer :min_hr
      t.integer :avg_hr
      t.integer :max_hr
      t.integer :cals_burned
      t.integer :pace
      t.integer :avg_rpms
      t.integer :distance

      t.timestamps
    end
  end

  def self.down
    drop_table :workouts
  end
end
