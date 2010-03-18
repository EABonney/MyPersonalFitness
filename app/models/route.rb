class Route < ActiveRecord::Base
  belongs_to :user
  belongs_to :workout
  has_many :route_points, :dependent => :destroy

  validates_length_of :name, {:on => :update, :maximum => 50, :message => "must not exceed 50 letters."}
  validates_presence_of :type, {:on => :update }
  validates_numericality_of :distance_mi, :distance_km, :user_id, {:on => :update}

  def to_routedata_json
    # only send over the lat,lng points as a json object.
    json_route_points = '\'['

    self.route_points.each do |route_point|
      json_route_points += '{"lat":' + route_point.lat.to_s + ',"lng":' + route_point.lng.to_s + '},'
    end

    # trim the trailing comma from the last object.
    json_route_points = json_route_points.chomp(',')
    json_route_points += ']\''
  end
end
