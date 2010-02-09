class SwimWorkout < Workout
  validates_numericality_of :pace, :distance
end