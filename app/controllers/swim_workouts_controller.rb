class SwimWorkoutsController < ApplicationController
  before_filter :require_user

  def index
  end

  def new
    @swim = @current_user.swim_workouts.new
  end

  def create
    @swim = @current_user.swim_workouts.new

    if @swim.save
      flash[:notice] = "Your swim workout was saved!"
      redirect_to workouts_url
    else
      render :action => :new
    end
  end
end
