class DaysController < ApplicationController
  before_filter :require_user

  def show
    if Date.valid_date?(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      @servings = Serving.where(user_id: @current_user, when_eaten: @date).order(:day_order)
      @calories = @servings.sum :calories
      @calorie_percent = (100.0 * @calories / current_user.daily_calorie_goal).to_i
      @calorie_percent_capped = [@calorie_percent, 100].min
      if @calorie_percent > 100
        @calorie_percent_type = "progress-bar-danger"
      elsif @calorie_percent > 85
        @calorie_percent_type = "progress-bar-warning"
      else
        @calorie_percent_type = "progress-bar-success"
      end

      render 'show'
    else
      redirect_to '/'
    end
  end

  def add
    if Date.valid_date?(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      day_order = Serving.where(user_id: @current_user, when_eaten: @date).maximum('day_order')
      @new_serving = Serving.create user: current_user, day_order: day_order.nil? ? 0 : day_order + 1, 
        quantity: params[:quantity].to_i, name: params[:add], calories: params[:calories], 
        when_eaten: @date

      return render partial: 'serving', object: @new_serving
    end
    :internal_server_error
  end

  def today
    params[:month] = Date.today.month
    params[:day] = Date.today.day
    params[:year] = Date.today.year    
    show
  end  
end
