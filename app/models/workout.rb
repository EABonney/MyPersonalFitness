require 'time'

class Workout < ActiveRecord::Base
  
  validates_numericality_of :user_id, :min_hr, :avg_hr, :max_hr, :cals_burned

  def getworkouttotalminutes
    totalminutes = ( self.duration.hour * 3600 + self.duration.min * 60 + self.duration.sec ) / 60
  end
end