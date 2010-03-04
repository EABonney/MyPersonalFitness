class WorkoutsController < ApplicationController
  before_filter :require_user, :only => [ :show, :new ]
  
  def show
    @month_show = params[:id]
  end

  def new
    @swim = @current_user.swim_workouts.new
    @bike = @current_user.bike_workouts.new
    @run = @current_user.run_workouts.new
  end
end
