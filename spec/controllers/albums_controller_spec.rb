require 'spec_helper'

describe AlbumsController do

  let(:album) {stub_model(Album)}

  before do
    user = stub_model(User)
    session[:user_id] = user.id
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
      User.any_instance.stub(:albums).and_return([album])
      get :index
      expect(assigns(:albums)).to eq([album])
    end
  end

  context 'with album' do
    let(:albums) {controller.current_user.albums}
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
      def valid_album? ret=true
        Album.any_instance.stub(:valid?).and_return(ret)
        post :update, :id => album.to_param
        response
      end

      it "assign a album as @album" do
        post :update, :id => album.to_param
        expect(assigns(:album)).to be_a(Album)
      end

      it { expect( valid_album? ).to redirect_to(albums_path) }
      it { expect( valid_album?(false) ).to render_template("edit") }

    end

    describe "DELETE destroy" do
      def destroy_album ret=true
        Album.any_instance.should_receive(:destroy).and_return(ret)
        delete :destroy, :id => album.to_param
        response
      end

      it { expect( destroy_album ).to redirect_to(albums_path) }
      it { expect( destroy_album(false) ).to render_template('show') }
    end

  end

  describe "POST create" do
    describe "with valid params" do
      let(:valid_post) { post :create, :album => attributes_for(:album); response }

      it { expect{ valid_post }.to change(Album, :count).by(1) }
      it { expect( valid_post ).to redirect_to(albums_path) }
      it "assigns a newly created album as @album" do
        valid_post
        expect(assigns(:album)).to be_a(Album)
      end
    end
    describe "with invalid params" do
      before do
        User.any_instance.stub(:save).and_return(false)
        post :create
      end

      it { expect(response).to render_template("new") }
      it "assigns a newly created but unsaved album as @album" do
        expect(assigns(:album)).to be_a_new(Album)
      end
    end
  end

  describe "GET search" do
    before do
      Album.stub(:search).and_return([album])
      get :search
    end
    it { expect(response).to render_template("index") }
    it 'assigns albums as @albums' do
      expect(assigns(:albums)).to eq([album])
    end
  end
end
