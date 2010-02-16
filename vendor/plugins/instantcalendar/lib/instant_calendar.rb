module InstantCalendar 
  module ViewHelpers 
    def show_calendar(options={})
 			render :partial => "instant_calendar/calendar",:locals => 
									{:month => options[:month] || Time.now.month,
									 :year => options[:year] || Time.now.year,
									 :highlight_today => options[:highlight_today] || false,
									 :dates => options[:dates]	|| [],
									 :highlight_dates => options[:highlight_dates]	|| [],
                   :navigation => options[:navigation] || false
                  }
    end

		def today?(i)
			Time.now.day == i
		end
	end
end

ActionView::Base.module_eval do
  include InstantCalendar::ViewHelpers
end
