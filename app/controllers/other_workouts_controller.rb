class OtherWorkoutsController < ApplicationController
  before_filter :require_user

  def index
  end

  def edit
    @routes = @current_user.routes.find :all
    @workout = @current_user.other_workouts.find(params[:id])
  end

  def new
    @routes = @current_user.routes.find :all
    @workout = @current_user.other_workouts.new
  end

  def create
    @other = @current_user.other_workouts.build(params[:other_workout])

    if @other.save
      flash[:notice] = "Your other workout was saved!"
      redirect_to dashboards_url
    else
      render :action => :new
    end
  end

  def update
    @other = @current_user.other_workouts.find(params[:id])
    if @other.update_attributes(params[:other_workout])
      flash[:notice] = "other workout has been updated!"
      redirect_to dashboards_url
    else
      render :action => :edit
    end
  end

  def destroy
    @other = @current_user.other_workouts.find(params[:id])
    @other.delete
    flash[:notice] = "Your other workout was successfully deleted!"
    redirect_to dashboards_url
  end
end

