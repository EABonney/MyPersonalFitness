class RoutePoint < ActiveRecord::Base
  belongs_to :route

  validates_numericality_of :lat, :lng, :route_id

end
