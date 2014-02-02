class ServingsController < ApplicationController
  before_filter :require_user
  respond_to :json

  def create
    serving_params = params.require(:serving).permit(:quantity, :name, :calories)

    serving = Serving.new serving_params
    serving.user = current_user
    serving.day_order = 0 # TODO: something!
    serving.when_eaten = Time.now # TODO: Correct date!
    serving.save!

    render text: '<id>%d</id>' % [serving.id]
  end

  def update
    params.require(:id)
    serving_params = params.require(:serving).permit(:quantity, :name, :calories, :id)

    serving = Serving.find params[:id]

    unless serving.user == current_user
      return :internal_error
    end

    serving.update_attributes serving_params

    # Render the partial for the serving, and put it in html.
    html = render_to_string partial: '/days/serving', object: serving
    render json: { action: 'update', id: serving.id, html: html }
  end

  def destroy
    params.require(:id)

    serving = Serving.find params[:id]

    unless serving.user == current_user
      return :internal_error
    end

    when_eaten = serving.when_eaten 
    serving.destroy

    calories = Serving.where(user_id: current_user, when_eaten: when_eaten).order(:day_order).sum(:calories)
    #calorie_percent = (100.0 * @calories / current_user.daily_calorie_goal).to_i
    #calorie_percent_capped = [@calorie_percent, 100].min

    render json: { action: 'delete', id: serving.id, calories: calories }
  end

  def move_up
    params.require(:id)
    serving = Serving.find_by_id! params[:id]
    serving.move_up
    render json: { action: 'move_up', id: serving.id }
  end

  def move_down
    params.require(:id)
    serving = Serving.find_by_id! params[:id]
    serving.move_down
    render json: { action: 'move_down', id: serving.id }
  end
end
