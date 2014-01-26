require 'spec_helper'

describe User do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is invalid with negative daily_calorie_goal" do
    expect(build(:user, daily_calorie_goal: -50)).to have(1).errors_on(:daily_calorie_goal)
  end  
end
