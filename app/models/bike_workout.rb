class BikeWorkout < Workout
  belongs_to :user
  validates_numericality_of :distance, :avg_rpms

  def calbikepace
    tot_minutes = self.getworkouttotalminutes
    base = (tot_minutes.to_f / 60.to_f).to_f.round(2)
    self.pace = (self.distance.to_f / base).round(2)
  end
end