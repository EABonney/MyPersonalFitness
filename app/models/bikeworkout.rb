class BikeWorkout < Workout
  validates_numericality_of :pace, :distance, :avg_rpms
end