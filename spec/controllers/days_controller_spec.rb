require 'spec_helper'

describe DaysController do
  context 'with params[:day] and params[:month] and params[:year]' do
    it "with a valid date, renders the :show template" do
      get :show, year: '2013', month: '12', day: '30'
      expect(response).to render_template :show
    end
  end
end
