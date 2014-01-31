require 'spec_helper'
require 'authlogic/test_case'
include Authlogic::TestCase

describe DaysController do
  setup :activate_authlogic

  context 'with params[:day] and params[:month] and params[:year]' do
    it "with a valid date, renders the :show template" do
      # TODO: Don't copy/paste this.
      user = create :user
      session = UserSession.create(user)
      # TODO: Don't copy/paste this.

      get :show, year: '2013', month: '12', day: '30'
      expect(response).to render_template :show
    end
  end
end
