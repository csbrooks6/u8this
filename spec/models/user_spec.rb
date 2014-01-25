require 'spec_helper'

describe User do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without a login" do
    expect(build(:user, login: nil)).to have(1).errors_on(:login)
  end

  it "is invalid with duplicate login" do
    @user1 = create(:user, login: "bob")
    @user2 = build(:user, login: "bob")
    expect(@user2).to have(1).errors_on(:login)
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
