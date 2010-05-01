# Methods added to this helper will be available to all templates in the application.
require 'time'

module ApplicationHelper
  def calculatepace(type, distance, time)
    if time.hour == 0 && time.min == 0 && time.sec == 0
      pace = 0
    else
      case type
      when "swim"
        pace = ((getworkouttotalminutes(time.hour, time.min, time.sec).to_f) / ( distance.to_f / 100.to_f )).round(2)
      when "bike"
        tot_minutes = getworkouttotalminutes(time.hour, time.min, time.sec)
        base = (tot_minutes.to_f / 60.to_f).to_f.round(2)
        pace = (distance.to_f / base).round(2)
      when "run"
        pace = (getworkouttotalminutes(time.hour, time.min, time.sec).to_f / distance.to_f).round(2)
      end
    end
  end

  def getworkouttotalminutes(hour, minutes, seconds)
    totalminutes = ( hour * 3600 + minutes * 60 + seconds ) / 60
  end
end
