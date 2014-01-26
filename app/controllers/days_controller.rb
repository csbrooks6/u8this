class DaysController < ApplicationController
  #before_filter :require_user

  def show
    if Date.valid_date?(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      render 'show'
    else
      redirect_to '/'
    end
  end

  def today
    params[:month] = Date.today.month
    params[:day] = Date.today.day
    params[:year] = Date.today.year    
    show
  end  
end
