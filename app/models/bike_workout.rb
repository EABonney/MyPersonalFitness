class BikeWorkout < Workout
  validates_numericality_of :distance, :avg_rpms

  def calbikepace
    self.pace = ( (self.distance / (self.getworkouttotalminutes / 60 ) ) )
  end
end