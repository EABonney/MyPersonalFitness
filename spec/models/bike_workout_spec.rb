require 'spec_helper'

describe BikeWorkout do
  before do
    @bike = BikeWorkout.new( :user_id => 1, :workout_date => "2010-01-01", :time_of_day => "00:00:00",
                             :duration => "00:30:00", :distance => 1300, :plan_type => "a")
  end

  it "should have user id assigned" do
    @bike.user_id = ''
    @bike.should_not be_valid
  end
  it "should have a type of bikeWorkout" do
    @bike.type.should == "BikeWorkout"
  end
  it "should have a workout date formatted as 'YYYY-MM-DD'" do
    @bike.workout_date = "2010-1-01"
    @bike.should_not be_valid
  end
  it "should have a time of day formatted as 'HH:MM:SS'" do
    @bike.time_of_day = "7:00:00"
    @bike.should_not be_valid
  end
  it "should have a duration formatted as 'HH:MM:SS'" do
    @bike.duration = "7:00:00"
    @bike.should_not be_valid
  end
  it "should have a distance" do
    @bike.distance = ''
    @bike.should_not be_valid
  end
  it "should have a plan type" do
    @bike.plan_type = 'j'
    @bike.should_not be_valid
  end
  it "should have a minimum heart rate" do
    @bike.min_hr = ''
    @bike.should_not be_valid
  end
  it "should have an average heart rate" do
    @bike.avg_hr = ''
    @bike.should_not be_valid
  end
  it "should have a maximum heart rate" do
    @bike.max_hr = ''
    @bike.should_not be_valid
  end
  it "should have a calories burned" do
    @bike.cals_burned = ''
    @bike.should_not be_valid
  end
  it "should have an average rpms" do
    @bike.avg_rpms = ''
    @bike.should_not be_valid
  end
end
