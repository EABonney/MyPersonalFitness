class RunWorkoutsController < ApplicationController
  before_filter :require_user

  def index
  end

  def edit
    @run = @current_user.run_workouts.find(params[:id])
  end

  def new
    @run = @current_user.run_workouts.new
  end

  def create
    @run = @current_user.run_workouts.build(params[:run_workout])
    @run.calrunpace
    
    if @run.save
      flash[:notice] = "Your run workout was saved!"
      redirect_to workouts_url
    else
      render :action => :new
    end
  end

  def update
    @run = @current_user.run_workouts.find(params[:id])
    if @run.update_attributes(params[:run_workout])
      flash[:notice] = "Run workout has been updated!"
      redirect_to workouts_url
    else
      render :action => :edit
    end
  end

  def destroy
    @run = @current_user.run_workouts.find(params[:id])
    @run.destroy
    flash[:notice] = "Run workout was successfully deleted!"
    redirect_to dashboards_url
  end
end
