require 'spec_helper'

describe RunWorkout do
  before do
    @run = RunWorkout.new( :user_id => 1, :workout_date => "2010-01-01", :time_of_day => "00:00:00",
                             :duration => "00:30:00", :distance => 1300, :plan_type => "a")
  end

  it "should have user id assigned" do
    @run.user_id = ''
    @run.should_not be_valid
  end
  it "should have a type of runWorkout" do
    @run.type.should == "RunWorkout"
  end
  it "should have a workout date formatted as 'YYYY-MM-DD'" do
    @run.workout_date = "2010-1-01"
    @run.should_not be_valid
  end
  it "should have a time of day formatted as 'HH:MM:SS'" do
    @run.time_of_day = "7:00:00"
    @run.should_not be_valid
  end
  it "should have a duration formatted as 'HH:MM:SS'" do
    @run.duration = "7:00:00"
    @run.should_not be_valid
  end
  it "should have a distance" do
    @run.distance = ''
    @run.should_not be_valid
  end
  it "should have a plan type" do
    @run.plan_type = 'j'
    @run.should_not be_valid
  end
  it "should have a minimum heart rate" do
    @run.min_hr = ''
    @run.should_not be_valid
  end
  it "should have an average heart rate" do
    @run.avg_hr = ''
    @run.should_not be_valid
  end
  it "should have a maximum heart rate" do
    @run.max_hr = ''
    @run.should_not be_valid
  end
  it "should have a calories burned" do
    @run.cals_burned = ''
    @run.should_not be_valid
  end
end
