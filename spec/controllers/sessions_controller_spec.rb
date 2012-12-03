require 'spec_helper'

describe SessionsController do
  describe "POST create" do
    let(:valid_attributes){attributes_for(:user).select{|key| [:password, :name].include? key }}
    its("with invalid params") { expect( post :create ).to redirect_to(login_path) }
    its("with valid params") do
      create(:user)
      expect( post :create, valid_attributes ).to redirect_to(root_path)
    end
  end

  describe "GET destroy" do
    it { expect( get :destroy ).to redirect_to(login_path) }
    it "resets session" do
      get :destroy, nil, user_id:1
      expect(session[:user_id]).to be_nil
    end
  end
end
