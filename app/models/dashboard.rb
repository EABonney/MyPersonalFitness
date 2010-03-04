class Dashboard < ActiveRecord::Base

  def format_greeting
    if Time.now.hour < 12
      "Good morning "
    elsif Time.now.hour >= 12 && Time.now.hour < 17
      "Good afternoon "
    else
      "Good evening "
    end
  end

end
