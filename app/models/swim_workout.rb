class SwimWorkout < Workout
  belongs_to :user
  validates_numericality_of :distance

  def calswimpace
    self.pace = ((self.getworkouttotalminutes.to_f) / ( self.distance.to_f / 100.to_f )).round(2)
  end
end