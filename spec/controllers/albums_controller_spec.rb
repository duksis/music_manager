require 'spec_helper'

describe AlbumsController do
  let(:log_in) do
    user = stub_model(User)
    session[:user_id] = user.id
    User.stub(:find).and_return(user)
  end

  let(:album) {stub_model(Album)}
  let(:albums) {controller.current_user.albums}

  before { log_in }

  describe "GET new" do
    it "assigns a new album as @album" do
      get :new
      expect(assigns(:album)).to be_a_new(Album)
    end
  end

  describe "GET index" do
    it "assign a list of albums as @albums" do
      User.any_instance.stub(:albums).and_return([album])
      get :index
      expect(assigns(:albums)).to eq([album])
    end
  end

  context 'with album' do
    before do
      albums.should_receive(:find).with(album.to_param).and_return(album)
    end

    describe "GET show" do
      it "assign a album as @album" do
        get :show, :id => album.to_param
        expect(assigns(:album)).to be_a(Album)
      end
      it "assign the cover_size as @cover_size" do
        get :show, :id => album.to_param, :cover_size => 'small'
        expect(assigns(:cover_size)).to eq('small')
      end
    end

    describe "GET edit" do
      it "assign a album as @album" do
        get :edit, :id => album.to_param
        expect(assigns(:album)).to be_a(Album)
      end
    end

    describe "POST update" do
      it "assign a album as @album" do
        post :update, :id => album.to_param
        expect(assigns(:album)).to be_a(Album)
      end

      it 'should redirect on sucess' do
        Album.any_instance.stub(:valid?).and_return(true)
        post :update, :id => album.to_param,:album => {}
        expect(response).to redirect_to(albums_path)
      end

      it 'should render edit on failure' do
        Album.any_instance.stub(:valid?).and_return(false)
        post :update, :id => album.to_param,:album => {}
        expect(response).to render_template("edit")
      end
    end

    describe "DELETE destroy" do
      before { Album.any_instance.should_receive(:destroy).and_return(true) }

      it "destroys the requested album" do
        delete :destroy, :id => album.to_param
      end

      it "redirects to the users list" do
        delete :destroy, :id => album.to_param
        response.should redirect_to(albums_url)
      end
    end

  end

  describe "POST create" do
    describe "with valid params" do
      let(:valid_attributes) {attributes_for(:album)}

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
      before do
        User.any_instance.stub(:save).and_return(false)
        post :create
      end

      it "assigns a newly created but unsaved album as @album" do
        expect(assigns(:album)).to be_a_new(Album)
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET search" do
    before do
      Album.stub(:search).and_return([album])
      get :search
    end

    it 'assigns albums as @albums' do
      expect(assigns(:albums)).to eq([album])
    end

    it 'renders index' do
      expect(response).to render_template("index")
    end
  end
end
