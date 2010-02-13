require 'time'

class Workout < ActiveRecord::Base
  belongs_to :user

  VALID_PLANTYPES = %w(a p)
  validates_numericality_of :user_id, :min_hr, :avg_hr, :max_hr, :cals_burned
  validates_format_of :workout_date,
                      :with => /[0-9]{4}-[0-9]{2}-[0-9]{2}/,
                      :message => "Date format must be: YYYY-MM-DD"
  validates_format_of :time_of_day, :duration,
                      :with => /(([01][0-9])|(2[0-3])):[0-5][0-9]:[0-5][0-9]/,
                      :message => "Time formats must be: HH:MM:SS"
  validates_inclusion_of :plan_type, :in => VALID_PLANTYPES

  def getworkouttotalminutes
    workout_time = Time.parse(self.duration)
    totalminutes = ( workout_time.hour * 3600 + workout_time.min * 60 + workout_time.sec ) / 60
  end
end