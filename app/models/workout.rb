require 'time'

class Workout < ActiveRecord::Base
  has_one :route
  
  validates_numericality_of :user_id, :min_hr, :avg_hr, :max_hr, :cals_burned

  def getworkouttotalminutes
    totalminutes = ( self.duration.hour * 3600 + self.duration.min * 60 + self.duration.sec ) / 60
  end

  def to_workoutdata_json
    json = '{"date":' + self.workout_date.strftime("%A %b %d, %Y") + ','
    json += '"duration":' + self.duration.strftime("%Hhrs %Mmins %Ssec") + ','
    json += '"distance":' + self.distance.to_s + ','
    json += '"pace":' + self.pace.to_s + ','
    json += '"notes":' + self.notes + ','
    json += '"type":' + self.type + ','
    json += '"route_id":' + self.route_id.to_s + ','
    if self.description
      json += '"description":' + self.description + ','
    end
    json += '"id":' + self.id.to_s + '},'
  end
end