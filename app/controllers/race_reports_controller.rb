class RaceReportsController < ApplicationController
  before_filter :require_user
  
  def index
    @race_reports = @current_user.race_reports.find :all
    @race_reports.sort! { |a,b| b.race.race_date <=> a.race.race_date }
  end

  def show
    @race_report = @current_user.race_reports.find(params[:id])
  end

  def edit
    @race_report = @current_user.race_reports.find(params[:id])
    @default = Time.mktime( 12, 1, 1, 0, 0, 0 )
  end

  def create
    @race_report = @current_user.race_reports.build(:race_id => params[:race_id])

    if @race_report.save
      flash[:notice] = "The race was added to your calendar!"
      redirect_to races_url
    else
      flash[:notice] = "There was an error adding that race to your calendar!"
      redirct_to races_url
    end
  end

  def update
    @race_report = @current_user.race_reports.find(params[:id])
    if @race_report.update_attributes(params[:race_report])
      flash[:notice] = "Your race report has been updated!"
      redirect_to race_reports_url
    else
      render :action => :edit
    end
  end
  
  def destroy
    @race_report = @current_user.race_reports.find(params[:id])
    @race_report.delete
    flash[:notice] = "Your race report was deleted!"
    redirect_to race_reports_url
  end
end
