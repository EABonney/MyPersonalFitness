class Race < ActiveRecord::Base
  has_many :race_reports
  has_many :users, :through => :race_reports
  
  validates_numericality_of :swim_distance, :bike_distance, :run_distance
  validates_presence_of :name, :race_type, :race_distance, :race_date
end
