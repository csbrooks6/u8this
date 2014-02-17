class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :list_foods]
  
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

  def list_foods
    query = params[:q]

    # Turn % into _
    # NOTE: I have a bad feeling about this, but what else should I do?
    # We need to match things like "3% beer", so we can't just strip the %.
    # Can't find a generalized way to escape it, though.
    query = query.gsub('%', '_')

    # If query is nothing but underscores, throw it out. (Would match everything.)
    if /^_*$/ =~ query
      return render json: {}
    end

    # Return a json array of all the names of foods the current user has ever entered.
    # (For use by typeahead.)
    foods = Food.where(user: @current_user).where('name LIKE ?', "%#{query}%").
      order(:name).collect {|f| {val: f.name} } 
    render json: foods
  end

  private
    def user_params
      params.require(:user).permit(:login, :email, :daily_calorie_goal, :password, :password_confirmation, :commit)
    end
end