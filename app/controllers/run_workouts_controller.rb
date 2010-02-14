class RunWorkoutsController < ApplicationController
  before_filter :require_user

  def index
  end

  def new
    @run = RunWorkout.new
  end

  def create
    @run = RunWorkout.new

    if @run.save
      flash[:notice] = "Your run workout was saved!"
      redirect_to workouts_url
    else
      render :action => :new
    end
  end
end
