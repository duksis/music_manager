require 'spec_helper'

describe AlbumsController do
  before do
    user = stub_model(User)
    controller.session[:user_id] = user.id
    User.stub(:find).and_return(user)
  end

  describe "GET new" do
    it "assigns a new album as @album" do
      get :new
      expect(assigns(:album)).to be_a_new(Album)
    end
  end

  describe "GET index" do
    it "assign a list of albums as @albums" do
      album = stub_model(Album)
      User.any_instance.stub(:albums).and_return([album])
      get :index
      expect(assigns(:albums)).to eq([album])
    end
  end

  describe "POST create" do
    describe "with valid params" do
      let(:valid_attributes) {FactoryGirl.attributes_for(:album)}

      it "creates a new Album" do
        expect {
          post :create, :album => valid_attributes
        }.to change(Album, :count).by(1)
      end

      it "assigns a newly created album as @album" do
        post :create, :album => valid_attributes
        expect(assigns(:album)).to be_a(Album)
      end

      it "redirects to the albums page" do
        post :create, :album => valid_attributes
        expect(response).to redirect_to(albums_path)
      end
    end
    describe "with invalid params" do
      it "assigns a newly created but unsaved album as @album" do
        User.any_instance.stub(:save).and_return(false)
        post :create
        expect(assigns(:album)).to be_a_new(Album)
      end

      it "re-renders the 'new' template" do
        User.any_instance.stub(:save).and_return(false)
        post :create
        expect(response).to render_template("new")
      end
    end
  end

end
