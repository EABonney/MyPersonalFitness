class BikeWorkoutsController < ApplicationController
  before_filter :require_user

  def index
  end

  def new
    @bike = BikeWorkout.new
  end

  def create
    @bike = BikeWorkout.new

    if @bike.save
      flash[:notice] = "Your bike workout was saved!"
      redirect_to workouts_url
    else
      render :action => :new
    end
  end
end
