class RunWorkout < Workout
  validates_numericality_of :distance

  def calrunpace
    self.pace = self.getworkouttotalminutes / self.distance
  end
end