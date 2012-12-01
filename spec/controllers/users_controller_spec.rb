require 'spec_helper'

describe UsersController  do

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      let(:valid_attributes) {attributes_for(:user)}

      it "creates a new User" do
        expect {
          post :create, :user => valid_attributes
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, :user => valid_attributes
        expect(assigns(:user)).to be_a(User)
      end

      it "redirects to the login page" do
        post :create, :user => valid_attributes
        expect(response).to redirect_to(login_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        User.any_instance.stub(:save).and_return(false)
        post :create
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        User.any_instance.stub(:save).and_return(false)
        post :create
        expect(response).to render_template("new")
      end
    end
  end

end
