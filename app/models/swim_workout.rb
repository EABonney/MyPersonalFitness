class SwimWorkout < Workout
  belongs_to :user, :class_name => "swim_workout"
  validates_numericality_of :distance

  def calswimpace
    self.pace = (self.getworkouttotalminutes) / ( self.distance / 100 )
  end
end