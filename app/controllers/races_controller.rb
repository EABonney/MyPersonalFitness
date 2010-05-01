class RacesController < ApplicationController
  before_filter :require_user
  before_filter :setdates

  def new
    @race = Race.new
    @race_types = RaceType::find :all
    respond_to do |wants|
      wants.html {
        render :template => '/races/new'
      }
      wants.urd {
        if params[:value].nil?
        else
          racetype_box_value = params[:value]
          selected = RaceType.find(:all, :select => 'race_distance',
            :conditions => ['race_type = ?', racetype_box_value])
          distances = '\'['
          selected.each do |s|
            distances += to_race_json(s)
          end
          # trim the trailing comma from the last object.
          distances = distances.chomp(',')
          distances += '\']'
          res={:success=>true, :content => distances}
          render :text=>res.to_json
        end
      }
    end
  end

  def show
    @race = Race.find(params[:id])
  end

  def index
    @races = Race.find :all
  end

  def edit
    @race = Race.find(params[:id])
  end

  def create
    @race = Race.create(params[:race])

    if @race.save
      flash[:notice] = "Your race was successfully created!"
      redirect_to races_url
    else
      render :action => :new
    end
  end

  def update
    @race = Race.find(params[:id])

    if @race.update_attributes(params[:race])
      flash[:notice] = "Your race has been updated!"
      redirect_to races_url
    else
      render :action => :edit
    end
  end

  def destroy
    @race = Race.find(params[:id])
    @race.delete
    flash[:notice] = "Your race was deleted!"
    redirect_to races_url
  end

private
  def setdates
    if params[:month].nil?
      @month_show = Date.today.month
    else
      @month_show = params[:month]
    end

    if params[:year].nil?
      @year_show = Date.today.year
    else
      @year_show = params[:year]
    end
  end

  def to_race_json(race_type)
    json = '{"distance":' + race_type.race_distance + '},'
  end
end
