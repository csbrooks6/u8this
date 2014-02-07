class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Account registered"
      redirect_to '/today'
    else
      flash[:notice] = "Error creating account"
      redirect_to '/account'
    end
  end
  
  def show
    @user = @current_user
  end

  def update
    @user = @current_user
    user_params = params.require(:user).permit(:daily_calorie_goal, :password, :password_confirmation)
    if @user.update_attributes(user_params)
      flash[:notice] = "Account updated"
      redirect_to '/account'
    else
      render :action => :show
    end
  end

  private
    def user_params
      params.require(:user).permit(:login, :email, :daily_calorie_goal, :password, :password_confirmation, :commit)
    end
end