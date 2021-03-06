class DashboardsController < ApplicationController
  before_filter :require_user, :only => [ :show, :change_workouts_display ]
 
  def show
      type = 'a'
      first_date = Date.today - Date.today.wday - 20
      last_date = Date.today + (7 - Date.today.wday) + 21
      @user = @current_user
      @swims = @current_user.swim_workouts.find :all, :conditions => ["workout_date >= ? and workout_date <= ? and plan_type = ?",
        first_date, last_date, type], :order => 'workout_date DESC'
      @bikes = @current_user.bike_workouts.find :all, :conditions => ["workout_date >= ? and workout_date <= ? and plan_type = ?",
        first_date, last_date, type], :order => 'workout_date DESC'
      @runs = @current_user.run_workouts.find :all, :conditions => ["workout_date >= ? and workout_date <= ? and plan_type = ?",
        first_date, last_date, type],  :order => 'workout_date DESC'
      @others = @current_user.other_workouts.find :all, :conditions => ["workout_date >= ? and workout_date <= ? and plan_type = ?",
        first_date, last_date, type],  :order => 'workout_date DESC'
      @workouts = @user.workouts.find :all, :conditions => ["workout_date >= ? and workout_date <= ? and plan_type = ?",
        first_date, last_date, type], :order => 'workout_date DESC'
      @current_month_totals = get_summary_totals(Date.new(Date.today.year, Date.today.month, 1),
                                    Date.new(Date.today.year, Date.today.month, -1))
      @prior_month_totals = get_summary_totals(Date.new(Date.today.year, Date.today.month-1, 1),
                                    Date.new(Date.today.year, Date.today.month-1, -1))
      @current_ytd_totals = get_summary_totals(Date.new(Date.today.year, 1, 1),
                                    Date.new(Date.today.year, 12, 31))
      @prior_ytd_totals = get_summary_totals(Date.new(Date.today.year-1, 1, 1),
                                    Date.new(Date.today.year-1, 12, 31))
      @upcoming_races = @current_user.race_reports.find :all, :include => [:race],
        :conditions => ["races.race_date >= ?", Date.today], :order => 'races.race_date ASC'
      @pr5k = @current_user.race_reports.find :all, :include => [:race],
        :conditions => ['races.race_distance = "5k" and races.race_date < ? and total_time != ?', Date.today, "null"],
        :limit => 1, :order => 'total_time ASC'
      @pr5k.empty? ? @pr5k = false : @pr5k = @pr5k.fetch(0)
      @pr10k = @current_user.race_reports.find :all, :include => [:race],
        :conditions => ['races.race_distance = "10k" and races.race_date < ? and total_time != ?', Date.today, "null"],
        :limit => 1, :order => 'total_time ASC'
      @pr10k.empty? ? @pr10k = false : @pr10k = @pr10k.fetch(0)
      @prHalfMarathon = @current_user.race_reports.find :all, :include => [:race],
        :conditions => ['races.race_distance = "Half-Marathon" and races.race_date < ? and total_time != ?', Date.today, "null"],
        :limit => 1, :order => 'total_time ASC'
      @prHalfMarathon.empty? ? @prHalfMarathon = false : @prHalfMarathon.fetch(0)
      @prMarathon = @current_user.race_reports.find :all, :include => [:race],
        :conditions => ['races.race_distance = "Marathon" and races.race_date < ? and total_time != ?', Date.today, "null"],
        :limit => 1, :order => 'total_time ASC'
      @prMarathon.empty? ? @prMarathon = false : @prMarathon.fetch(0)
      @prTri_Sprint = @current_user.race_reports.find :all, :include => [:race],
        :conditions => ['races.race_distance = "Sprint" and races.race_date < ? and total_time != ?', Date.today, "null"],
        :limit => 1, :order => 'total_time ASC'
      @prTri_Sprint.empty? ? @prTri_Sprint = false : @prTri_Sprint = @prTri_Sprint.fetch(0)
      @prTri_Olympic = @current_user.race_reports.find :all, :include => [:race],
        :conditions => ['races.race_distance = "Olympic" and races.race_date < ? and total_time != ?', Date.today, "null"],
        :limit => 1, :order => 'total_time ASC'
      @prTri_Olympic.empty? ? @prTri_Olympic = false : @prTri_Olympic = @prTri_Olympic.fetch(0)
      @prTri_HIM = @current_user.race_reports.find :all, :include => [:race],
        :conditions => ['races.race_distance = "Half-Ironman" and races.race_date < ? and total_time != ?', Date.today, "null"],
        :limit => 1, :order => 'total_time ASC'
      @prTri_HIM.empty? ? @prTri_HIM = false : @prTri_HIM = @prTri_HIM.fetch(0)
      @prTri_Ironman = @current_user.race_reports.find :all, :include => [:race],
        :conditions => ['races.race_distance = "Ironman" and races.race_date < ? and total_time != ?', Date.today, "null"],
        :limit => 1, :order => 'total_time ASC'
      @prTri_Ironman.empty? ? @prTri_Ironman = false : @prTri_Ironman = @prTri_Ironman.fetch(0)
      @dates = get_highlight_dates
      @month_show = params[:id]

    respond_to do |wants|
      wants.html {
        @graph = open_flash_chart_object( 275, 225, url_for( :action => 'show', :format => :json ) )
      }
      wants.json {
        chart = create_volume_graph
        render :text => chart, :layout => false
      }
    end
  end

  def change_workouts_display
    if params[:type] == 'p'
      type = params[:type]
      first_date = Date.today
      last_date = Date.today + 7
      @user = @current_user
      @workouts = @user.workouts.find :all, :conditions => ["workout_date >= ? and workout_date <= ? and plan_type = ?",
        first_date, last_date, type], :order => 'workout_date ASC'
    elsif params[:type] == 'a'
      type = params[:type]
      last_date = Date.today
      first_date = Date.today - 7
      @user = @current_user
      @workouts = @user.workouts.find :all, :conditions => ["workout_date >= ? and workout_date <= ? and plan_type = ?",
        first_date, last_date, type], :order => 'workout_date DESC'
    end

    returned_workouts = '\'['
    @workouts.each do |workout|
      returned_workouts += workout.to_workoutdata_json
    end
    # trim the trailing comma from the last object.
    returned_workouts = returned_workouts.chomp(',')
    returned_workouts += ']\''
    res={:success=>true, :content => returned_workouts}
    render :text=>res.to_json
  end
  
  private
  def create_volume_graph
    OpenFlashChart.new( "Weekly vs Planned Volume" ) do |c|
          weekly_durations = get_durations('a')
          planned_durations = get_durations('p')

          c << BarDome.new( :values => weekly_durations )
          c << Line.new( :values => planned_durations )
          c.bg_colour = '#e2edff'

          # labels along the x axis
          x_axis = XAxis.new
          x_axis.set_colour('#000080')
          x_axis.set_grid_colour('#e2edff')
          x_axis.labels = get_labels
          c.x_axis = x_axis
          x_legend = XLegend.new("Week Ending")
          x_legend.set_style('{font-size: 10px; color: "#000080"}')
          c.set_x_legend(x_legend)

          # y axis range, need to change this from hard coded.
          y_axis = YAxis.new
          y_axis.set_colour('#000080')
          y_axis.set_grid_colour('#e2edff')
          if (weekly_durations.max > planned_durations.max)
            y_range = weekly_durations.max
          else
            y_range = planned_durations.max
          end
          y_steps = set_y_axis_steps(y_range)
          y_axis.set_range(0, y_range, y_steps)
          c.y_axis = y_axis
          y_legend = YLegend.new("Minutes")
          y_legend.set_style('{font-size: 10px; color: "#000080"}')
          c.set_y_legend(y_legend)
        end
  end

  def get_durations(type)
    # Set the beginning date of the graph.
    first_date = Date.today - Date.today.wday - 20
    last_date = Date.today + (7 - Date.today.wday) + 21
    week_ending = first_date + 6

    # Get the workouts that we want to display on the graph
    actual_workouts = @current_user.workouts.find :all, :conditions => ["workout_date >= ? and workout_date <= ? and plan_type = ?",
      first_date, last_date, type], :order => 'workout_date ASC'

    # Create the weekly bar graph data from the duration of each workout.
    durations = Array.new
    temp = 0
    actual_workouts.each do |actual_workout|
      while actual_workout.workout_date > week_ending && week_ending <= last_date
        durations << temp
        week_ending = week_ending + 7
        temp = 0
      end
      temp = temp + (actual_workout.duration.hour * 60) + (actual_workout.duration.min) + (actual_workout.duration.sec / 60)
    end
    
    # Now that we are out of the workouts, see if we have any remaining weeks to add to duration as zeros.
    while week_ending <= last_date
      durations << temp
      week_ending = week_ending + 7
      temp = 0
    end
    durations
  end

  def get_labels
     # Set the beginning date of the graph.
    first_date = Date.today - Date.today.wday - 20

    # Create the labels for the graph.
    weeks = Array.new
    7.times do
      first_date = first_date + 6
      weeks << first_date.strftime("%m/%d")
      first_date = first_date + 1
    end
    weeks
  end

  def get_highlight_dates
    first_date = Date.new(Date.today.year, Date.today.month, 1)
    last_date = Date.new(Date.today.year, Date.today.month, -1)
    workouts = @current_user.workouts.find :all,  :conditions => ["workout_date >= ? and workout_date <= ? and plan_type = ?",
      first_date, last_date, 'a'], :order => 'workout_date ASC', :group => "workout_date", :select => 'workout_date'
    dates = Array.new
    workouts.each do |workout|
      dates << workout.workout_date.day
    end
    dates
  end

  def set_y_axis_steps(max_value)
    (max_value / 15).round
  end

  def get_summary_totals(begin_date, end_date)
    totals = Hash.new
    swims = @current_user.swim_workouts.find :all, :conditions => ["workout_date >= ? and workout_date <= ? and plan_type = ?",
      begin_date, end_date, 'a'], :select => 'duration, distance'
    bikes = @current_user.bike_workouts.find :all, :conditions => ["workout_date >= ? and workout_date <= ? and plan_type = ?",
      begin_date, end_date, 'a'], :select => 'duration, distance'
    runs = @current_user.run_workouts.find :all, :conditions => ["workout_date >= ? and workout_date <= ? and plan_type = ?",
      begin_date, end_date, 'a'], :select => 'duration, distance'
    others = @current_user.other_workouts.find :all, :conditions => ["workout_date >= ? and workout_date <= ? and plan_type = ?",
      begin_date, end_date, 'a'], :select => 'duration, distance'

    dur = 0.0
    dist = 0.0
    swims.each do |swim|
      dist += swim.distance
      dur += (swim.duration.hour * 60) + (swim.duration.min) + (swim.duration.sec / 60)
    end
    totals["swim_distance"] = dist
    totals["swim_duration"] = dur

    dur = 0.0
    dist = 0.0
    bikes.each do |bike|
      dist += bike.distance
      dur += (bike.duration.hour * 60) + (bike.duration.min) + (bike.duration.sec / 60)
    end
    totals["bike_distance"] = dist
    totals["bike_duration"] = dur

    dur = 0.0
    dist = 0.0
    runs.each do |run|
      dist += run.distance
      dur += (run.duration.hour * 60) + (run.duration.min) + (run.duration.sec / 60)
    end
    totals["run_distance"] = dist
    totals["run_duration"] =dur

    dur = 0.0
    dist = 0.0
    others.each do |other|
      dist += other.distance
      dur += (other.duration.hour * 60) + (other.duration.min) + (other.duration.sec / 60)
    end
    totals["other_distance"] = dist
    totals["other_duration"] = dur
    totals
  end
end