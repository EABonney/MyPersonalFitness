class SwimWorkoutsController < ApplicationController
  before_filter :require_user

  def index
  end

  def edit
    @swim = @current_user.swim_workouts.find(params[:id])
  end

  def new
    @routes = @current_user.routes.find :all
    @workout = @current_user.swim_workouts.new
  end

  def create
    @swim = @current_user.swim_workouts.build(params[:swim_workout])
    @swim.calswimpace
    
    if @swim.save
      flash[:notice] = "Your swim workout was saved!"
      redirect_to dashboards_url
    else
      render :action => :new
    end
  end

  def update
    @swim = @current_user.swim_workouts.find(params[:id])
    if @swim.update_attributes(params[:swim_workout])
      flash[:notice] = "Swim workout has been updated!"
      redirect_to dashboards_url
    else
      render :action => :edit
    end
  end

  def destroy
    @swim = @current_user.swim_workouts.find(params[:id])
    @swim.destroy
    flash[:notice] = "Your swim workout was successfully deleted!"
    redirect_to dashboards_url
  end
end
