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
      let(:post_create) {post :create, :user => attributes_for(:user); response}

      it { expect{ post_create }.to change(User, :count).by(1) }
      it { expect( post_create ).to redirect_to(login_path) }
      it "assigns a newly created user as @user" do
        post_create
        expect(assigns(:user)).to be_a(User)
      end

    end

    describe "with invalid params" do
      before do
        User.any_instance.stub(:save).and_return(false)
        post :create
      end
      it { expect(response).to render_template("new") }
      it "assigns a newly created but unsaved user as @user" do
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end

end
