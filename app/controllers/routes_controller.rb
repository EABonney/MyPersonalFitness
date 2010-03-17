require 'crack/json'

class RoutesController < ApplicationController
  before_filter :require_user

  def index
    @routes = @current_user.routes.find :all
  end

  def show
    @route = @current_user.routes.find(params[:id])
    @json_points = @route.to_routedata_json
    @user = @current_user
  end

  def edit
    @route = @current_user.routes.find(params[:id])
    @json_points = @route.to_routedata_json
    @user = @current_user
  end

  def new
    @user = @current_user
    @route = @user.routes.new
  end

  def create
    @route = @current_user.routes.create
    @route.name = params[:name]
    @route.distance_mi = params[:distMi]
    @route.distance_km = params[:distKm]
    @route.route_type = params[:route_type]
    data_points = Crack::JSON.parse(params[:jsonPoints])

    data_points.each do |data_point|
      @route.route_points.build( :lat => data_point['lat'], :lng => data_point['lng'] )
    end
    
    if @route.save
      res={:success=>true}
    else
      res={:success=>false,:content=>"Unable to save the route. If you could email the webmaster the
                date and time you received this message it would be helpful."}
    end

    render :text=>res.to_json
  end

  def update

  end
  
  def destroy
    @route = @current_user.routes.find(params[:id])
    @route.destroy
    flash[:notice] = "Route was successfully deleted!"
    redirect_to routes_url
  end
end
