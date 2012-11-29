require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    let(:valid_attributes) do
      FactoryGirl.attributes_for(:user).select{|key| [:password, :name].include? key }
    end
    describe "with valid params" do
      it "redirects to the homepage" do
        user = FactoryGirl.create(:user)

        post :create, valid_attributes
        response.should redirect_to(root_url)
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create
        response.should render_template("new")
      end
    end
  end

end
