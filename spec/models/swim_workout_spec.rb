require 'spec_helper'

describe SwimWorkout do
  before do
    @swim = SwimWorkout.new( :user_id => 1, :workout_date => "2010-01-01", :time_of_day => "00:00:00",
                             :duration => "00:30:00", :distance => 1300, :plan_type => "a")
  end

  it "should have user id assigned" do
    @swim.user_id = ''
    @swim.should_not be_valid
  end
  it "should have a type of SwimWorkout" do
    @swim.type.should == "SwimWorkout"
  end
  it "should have a workout date formatted as 'YYYY-MM-DD'" do
    @swim.workout_date = "2010-1-01"
    @swim.should_not be_valid
  end
  it "should have a time of day formatted as 'HH:MM:SS'" do
    @swim.time_of_day = "7:00:00"
    @swim.should_not be_valid
  end
  it "should have a duration formatted as 'HH:MM:SS'" do
    @swim.duration = "7:00:00"
    @swim.should_not be_valid
  end
  it "should have a distance" do
    @swim.distance = ''
    @swim.should_not be_valid
  end
  it "should have a plan type" do
    @swim.plan_type = 'j'
    @swim.should_not be_valid
  end
  it "should have a minimum heart rate" do
    @swim.min_hr = ''
    @swim.should_not be_valid
  end
  it "should have an average heart rate" do
    @swim.avg_hr = ''
    @swim.should_not be_valid
  end
  it "should have a maximum heart rate" do
    @swim.max_hr = ''
    @swim.should_not be_valid
  end
  it "should have a calories burned" do
    @swim.cals_burned = ''
    @swim.should_not be_valid
  end
end
