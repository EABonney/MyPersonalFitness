require 'time'

class Workout < ActiveRecord::Base
  
  validates_numericality_of :user_id, :min_hr, :avg_hr, :max_hr, :cals_burned
  #validates_format_of :workout_date,
  #                    :with => /[0-9]{4}-[0-9]{2}-[0-9]{2}/,
  #                    :message => "Date format must be: YYYY-MM-DD"
  #validates_format_of :time_of_day, :duration,
  #                    :with => /(([01][0-9])|(2[0-3])):[0-5][0-9]:[0-5][0-9]/,
  #                    :message => "Time formats must be: HH:MM:SS"

  def getworkouttotalminutes
    totalminutes = ( self.duration.hour * 3600 + self.duration.min * 60 + self.duration.sec ) / 60
  end
end