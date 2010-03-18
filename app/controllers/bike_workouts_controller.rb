class BikeWorkoutsController < ApplicationController
  before_filter :require_user

  def index
  end

  def edit
    @bike = @current_user.bike_workouts.find(params[:id])
  end

  def new
    @routes = @current_user.routes.find :all
    @workout = @current_user.bike_workouts.new
  end

  def create
    @bike = @current_user.bike_workouts.build(params[:bike_workout])
    @bike.calbikepace

    if @bike.save
      flash[:notice] = "Your bike workout was saved!"
      redirect_to dashboards_url
    else
      render :action => :new
    end
  end

  def update
    @bike = @current_user.bike_workouts.find(params[:id])
    if @bike.update_attributes(params[:bike_workout])
      flash[:notice] = "Bike workout has been updated!"
      redirect_to dashboards_url
    else
      render :action => :edit
    end
  end

  def destroy
    @bike = @current_user.bike_workouts.find(params[:id])
    @bike.delete
    flash[:notice] = "Your bike workout was successfully deleted!"
    redirect_to dashboards_url
  end
end
