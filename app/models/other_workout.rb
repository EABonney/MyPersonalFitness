class OtherWorkout < Workout
  belongs_to :user
  validates_numericality_of :distance
  validates_length_of :description, :maximum => 50
end
