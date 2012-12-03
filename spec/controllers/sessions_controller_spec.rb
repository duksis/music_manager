require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    let(:valid_attributes) do
      attributes_for(:user).select{|key| [:password, :name].include? key }
    end
    describe "with valid params" do
      it "redirects to the homepage" do
        user = create(:user)

        post :create, valid_attributes
        expect(response).to redirect_to(root_path)
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create
        expect(response).to redirect_to(login_path)
      end
    end
  end

end
