class WorkoutsController < ApplicationController
  before_filter :require_user, :only => [ :show, :new, :index ]
  before_filter :setdates


  def show
    @daily_workouts = @current_user.workouts.find :all, :conditions => [ "workout_date = ? and plan_type = ?",
      @show_date, 'a' ]
    @dates = get_highlight_dates
    @links = set_date_links
    @monthly_totals = get_summary_totals( Date.new(@year_show.to_i, @month_show.to_i, 1),
                        Date.new(@year_show.to_i, @month_show.to_i, -1) )
  end
  
  def index
    @dates = get_highlight_dates
    @links = set_date_links
    @monthly_totals = get_summary_totals( Date.new(@year_show.to_i, @month_show.to_i, 1),
                        Date.new(@year_show.to_i, @month_show.to_i, -1) )
  end

private
  def setdates
    if params[:month].nil?
      @month_show = Date.today.month
    else
      @month_show = params[:month]
    end

    if params[:year].nil?
      @year_show = Date.today.year
    else
      @year_show = params[:year]
    end

    if params[:id].nil?
      @show_date = Date.new( @year_show.to_i, @month_show.to_i, 1 )
    else
      date_parts = params[:id].split('-')
      @show_date = Date.new( date_parts[0].to_i, date_parts[1].to_i, date_parts[2].to_i )
      @month_show = @show_date.month
      @year_show = @show_date.year
    end
  end

  def get_highlight_dates
    first_date = Date.new(@year_show.to_i, @month_show.to_i, 1)
    last_date = Date.new(@year_show.to_i, @month_show.to_i, -1)
    workouts_display = @current_user.workouts.find :all,  :conditions => ["workout_date >= ? and workout_date <= ? and plan_type = ?",
      first_date, last_date, 'a'], :order => 'workout_date ASC', :group => "workout_date", :select => 'workout_date'
    dates = Array.new
    workouts_display.each do |workout|
      dates << workout.workout_date.day
    end
    dates
  end

  def set_date_links
    cur_date = Date.new(@year_show.to_i, @month_show.to_i, 1)
    last_date = Date.new(@year_show.to_i, @month_show.to_i, -1)
    link = Hash.new
    while cur_date <= last_date
      link[cur_date.day] = @template.link_to(cur_date.day.to_s, :controller => 'workouts',
          :id => cur_date, :action => 'show')
      cur_date = cur_date + 1
    end
    link
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