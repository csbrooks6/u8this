class DaysController < ApplicationController
  before_filter :require_user

  def show
    if Date.valid_date?(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)

      @servings = Serving.find_servings_for_user_for_day @current_user, @date

      progress_bar_locals = DaysController.get_progress_bar_locals @current_user, @date
      @progress_bar_html = render_to_string partial: '/days/progress_bar', formats: [:html], locals: progress_bar_locals

      render 'show'
    else
      redirect_to '/'
    end
  end

  # Returns a hash with the locals we need to render the progress bar partial.
  def self.get_progress_bar_locals user, date
    servings = Serving.find_servings_for_user_for_day user, date
    calories = servings.sum :calories
    calorie_percent = (100.0 * calories / user.daily_calorie_goal).to_i
    calorie_percent_capped = [calorie_percent, 100].min
    if calorie_percent > 100
      calorie_percent_type = "progress-bar-danger"
    elsif calorie_percent > 85
      calorie_percent_type = "progress-bar-warning"
    else
      calorie_percent_type = "progress-bar-success"
    end

    return {
      calories: calories, 
      calorie_percent: calorie_percent, 
      calorie_percent_capped: calorie_percent_capped, 
      calorie_percent_type: calorie_percent_type
    }
  end

  
  def today
    params[:month] = Date.today.month
    params[:day] = Date.today.day
    params[:year] = Date.today.year
    
    show
  end  
end
