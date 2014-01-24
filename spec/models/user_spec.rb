require 'spec_helper'

describe User do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without a username" do
    expect(build(:user, username: nil)).to have(1).errors_on(:username)
  end

  it "is invalid with duplicate username" do
    @user1 = create(:user, username: "bob")
    @user2 = build(:user, username: "bob")
    expect(@user2).to have(1).errors_on(:username)
  end

  it "is invalid without email" do
    expect(build(:user, email: nil)).to have(1).errors_on(:email)
  end

  it "is invalid with duplicate email" do
    @user1 = create(:user, email: "bob@bob.com")
    @user2 = build(:user, email: "bob@bob.com")
    expect(@user2).to have(1).errors_on(:email)
  end  

  it "is invalid with negative daily_calorie_goal" do
    expect(build(:user, daily_calorie_goal: -50)).to have(1).errors_on(:daily_calorie_goal)
  end  
end
