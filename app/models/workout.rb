class Workout < ActiveRecord::Base
  belongs_to :user
  validates_numericality_of :min_hr, :avg_hr, :max_hr, :cals_burned
  validates_presence_of :workout_date, :duration, :time_of_day
  validates_length_of :plan_type, :is => 1

end