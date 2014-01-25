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
      redirect_back_or_default @user
    else
      flash[:notice] = "Error creating account"
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:login, :email, :password, :password_confirmation, :commit)
    end
end