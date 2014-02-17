class ServingsController < ApplicationController
  before_filter :require_user
  respond_to :json

  def create
    serving_params = params.require(:serving).permit(:quantity, :name, :calories, :when_eaten)

    # Find the next day_order index for this day.
    day_order = Serving.where(user_id: current_user.id, 
      when_eaten: serving_params['when_eaten']).maximum(:day_order)
    if day_order.nil?
      day_order = 0
    else
      day_order += 1
    end

    serving = Serving.new attributes: serving_params
    serving.user = current_user
    serving.day_order = day_order
    serving.save!

    Food.addref current_user, serving.name

    html = render_to_string partial: '/days/serving', object: serving, formats: [:html]
    progress_bar_locals = DaysController.get_progress_bar_locals current_user, serving.when_eaten
    progress_bar_html = render_to_string partial: '/days/progress_bar', formats: [:html], locals: progress_bar_locals

    render json: { action: 'add', id: serving.id, html: html, progress_bar_html: progress_bar_html }
  end

  def update
    params.require(:id)
    serving_params = params.require(:serving).permit(:quantity, :name, :calories, :id)

    serving = Serving.find params[:id]

    unless serving.user == current_user
      return :internal_error
    end

    old_name = serving.name

    serving.update_attributes serving_params

    if old_name != serving.name
      Food.addref current_user, serving.name
      Food.release current_user, old_name
    end

    # Render the partial for the serving, and put it in html.
    html = render_to_string partial: '/days/serving', object: serving
    progress_bar_locals = DaysController.get_progress_bar_locals current_user, serving.when_eaten
    progress_bar_html = render_to_string partial: '/days/progress_bar', formats: [:html], locals: progress_bar_locals

    render json: { action: 'update', id: serving.id, html: html, progress_bar_html: progress_bar_html }
  end

  def destroy
    params.require(:id)

    serving = Serving.find params[:id]

    unless serving.user == current_user
      return :internal_error
    end

    when_eaten = serving.when_eaten 
    day_order = serving.day_order

    Food.release current_user, serving.name

    serving.destroy

    # All servings past this one get moved up.
    Serving.find_servings_for_user_for_day(current_user, when_eaten).where(
      'day_order > ?', day_order).find_each do |s|
      s.day_order -= 1
      s.save
    end

    progress_bar_locals = DaysController.get_progress_bar_locals current_user, serving.when_eaten
    progress_bar_html = render_to_string partial: '/days/progress_bar', formats: [:html], locals: progress_bar_locals

    render json: { action: 'delete', id: serving.id, progress_bar_html: progress_bar_html }
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
