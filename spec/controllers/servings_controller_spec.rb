require 'spec_helper'
require 'authlogic/test_case'
include Authlogic::TestCase

describe ServingsController do
  # Authorize.
  setup :activate_authlogic
  before :each do
    @current_user = user = create :user
    @current_session = session = UserSession.create(user)
  end

  describe "POST 'create'" do
    it "requires a serving param" do      
      expect { post :create }.to raise_error(ActionController::ParameterMissing)
    end

    context "with valid serving params" do
      before :each do
        @start_serving_count = Serving.count
        fake_serving_hash = attributes_for(:serving).except(:user, :day_order)
        post :create, serving: fake_serving_hash
        @xml_response = Nokogiri::XML(response.body)
        @end_serving_count = Serving.count
      end

      it "returns http success" do
        response.should be_success
      end

      it "creates one new serving" do
        expect(@end_serving_count - @start_serving_count).to eq(1)
      end

      it "returns a valid new serving in JSON" do
        json = JSON.parse response.body
        id = json['id'].to_i
        expect(Serving.find(id)).to be_valid
      end

      it "returns a new serving with day_order 0" do
        json = JSON.parse response.body
        id = json['id'].to_i
        expect(Serving.find(id).day_order).to eq(0)
      end
    end

    context "with one serving already existing for today" do
      before :each do
        serving = create :serving, user: @current_user, when_eaten: Date.today
        @start_serving_count = Serving.count
        fake_serving_hash = attributes_for(:serving).except(:user, :day_order)
        fake_serving_hash['when_eaten'] = Date.today
        post :create, serving: fake_serving_hash
        @xml_response = Nokogiri::XML(response.body)
        @end_serving_count = Serving.count
      end

      it "returns http success" do
        response.should be_success
      end

      it "creates one new serving" do
        expect(@end_serving_count - @start_serving_count).to eq(1)
      end

      it "returns a valid new serving in JSON" do
        json = JSON.parse response.body
        id = json['id'].to_i
        expect(Serving.find(id)).to be_valid
      end

      it "returns a new serving with day_order 1" do
        json = JSON.parse response.body
        id = json['id'].to_i
        expect(Serving.find(id).day_order).to eq(1)
      end
    end
  end


  describe "POST 'update'" do
    context "with an existing valid serving" do
      before :each do 
        @serving = FactoryGirl.create(:serving, user: @current_user)
      end

      it "returns http success" do
        post :update, id: @serving.id, serving: {name: 'blah', quantity: 4.4, calories: 333 }
        response.should be_success
      end

      it "updates the serving record" do
        post :update, id: @serving.id, serving: {name: 'blah', quantity: 4.4, calories: 333 }        
        @serving.reload
        expect(@serving.name).to eq('blah')
        expect(@serving.quantity).to eq(4.4)
        expect(@serving.calories).to eq(333)
      end
    end
  end

  describe "POST 'destroy'" do
    context "with an existing valid serving" do
      before :each do 
        @serving = FactoryGirl.create(:serving, user: @current_user)
      end

      it "returns http success" do
        post :destroy, id: @serving.id
        response.should be_success
      end

      it "deletes the serving record" do
        id = @serving.id
        post :destroy, id: id
        expect(Serving.exists?(id)).to be_false
      end
    end

    context "with a non-existing serving id" do
      it "raises an exception" do
        expect { post :destroy, id: 999 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end      
  end

  describe "POST 'move_up'" do
    context "with a non-existing serving id" do
      it "raises an exception" do
        expect { post :move_up, id: 999 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "with three existing valid servings" do
      before :each do
        @servings = [
          FactoryGirl.create(:serving, when_eaten: Date.today, user: @current_user, day_order: 0),
          FactoryGirl.create(:serving, when_eaten: Date.today, user: @current_user, day_order: 1),
          FactoryGirl.create(:serving, when_eaten: Date.today, user: @current_user, day_order: 2)
        ]
      end

      it "returns http success" do
        post :move_up, id: @servings[1].id
        expect(response).to be_success
      end

      it "moves the middle one up" do
        #puts "\n\n\n\n%s\n\n\n\n"%[@servings[0].day_order]
        post :move_up, id: @servings[1].id
        @servings.each do |s| s.reload end
        expect(@servings[0].day_order).to eq(1)
        expect(@servings[1].day_order).to eq(0)
        expect(@servings[2].day_order).to eq(2)
      end

      it "trying to move the first one up fails" do
        expect { post :move_up, id: @servings[0] }.to raise_error(ActiveRecord::RecordNotFound)
      end

    end    
  end

  describe "POST 'move_down'" do
    context "with a non-existing serving id" do
      it "raises an exception" do
        expect { post :move_down, id: 999 }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "with three existing valid servings" do
      before :each do
        @servings = [
          FactoryGirl.create(:serving, when_eaten: Date.today, user: @current_user, day_order: 0),
          FactoryGirl.create(:serving, when_eaten: Date.today, user: @current_user, day_order: 1),
          FactoryGirl.create(:serving, when_eaten: Date.today, user: @current_user, day_order: 2)
        ]
      end

      it "returns http success" do
        post :move_up, id: @servings[1].id
        expect(response).to be_success
      end

      it "moves the middle one down" do
        post :move_down, id: @servings[1].id
        @servings.each do |s| s.reload end
        expect(@servings[0].day_order).to eq(0)
        expect(@servings[1].day_order).to eq(2)
        expect(@servings[2].day_order).to eq(1)
      end

      it "trying to move the last one down fails" do
        expect { post :move_down, id: @servings[2] }.to raise_error(ActiveRecord::RecordNotFound)
      end

    end
  end
end
