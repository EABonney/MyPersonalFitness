class RunWorkout < Workout
  belongs_to :user
  validates_numericality_of :distance

  def calrunpace
    self.pace = (self.getworkouttotalminutes.to_f / self.distance.to_f).round(2)
  end
end