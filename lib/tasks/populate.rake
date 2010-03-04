# lib/tasks/populate.rake
namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'

    earliest_time = Time.parse('07:00')
    latest_time = Time.parse('21:00')
    shortest_duration = Time.parse('00:10:00')
    longest_duration = Time.parse('03:00:00')

    [Workout].each(&:delete_all)

    SwimWorkout.populate 10 do |swim|
      swim.user_id = 1
      swim.workout_date = 7.day.ago..Time.now
      swim.time_of_day = earliest_time + rand(latest_time - earliest_time)
      swim.duration = shortest_duration + rand(longest_duration - shortest_duration)
      swim.distance = 500..4500
      swim.plan_type = 'a'
      swim.type = "SwimWorkout"
      swim.notes = Populator.paragraphs(3)
      swim.min_hr = 80..180
      swim.avg_hr = 80..180
      swim.max_hr = 80..180
      swim.cals_burned = 100..400
      swim.pace = 0
      swim.avg_rpms = 0
    end

    BikeWorkout.populate 10 do |bike|
      bike.user_id = 1
      bike.workout_date = 7.day.ago..Time.now
      bike.time_of_day = earliest_time + rand(latest_time - earliest_time)
      bike.duration = shortest_duration + rand(longest_duration - shortest_duration)
      bike.distance = 5..65
      bike.plan_type = 'a'
      bike.type = "BikeWorkout"
      bike.notes = Populator.paragraphs(3)
      bike.min_hr = 80..180
      bike.avg_hr = 80..180
      bike.max_hr = 80..180
      bike.cals_burned = 100..400
      bike.pace = 0
      bike.avg_rpms = 78..90
    end

    RunWorkout.populate 10 do |run|
      run.user_id = 1
      run.workout_date = 7.day.ago..Time.now
      run.time_of_day = earliest_time + rand(latest_time - earliest_time)
      run.duration = shortest_duration + rand(longest_duration - shortest_duration)
      run.distance = 2..12
      run.plan_type = 'a'
      run.type = "RunWorkout"
      run.notes = Populator.paragraphs(3)
      run.min_hr = 80..180
      run.avg_hr = 80..180
      run.max_hr = 80..180
      run.cals_burned = 100..400
      run.pace = 0
      run.avg_rpms = 0
    end
  end
end
