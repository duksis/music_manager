class AlbumsController < ApplicationController
  before_filter :login_required

  def new
    @album = user_albums.new
  end

  def index
    @albums = user_albums
  end

  def create
    @album = user_albums.new(params[:album])
    if @album.save
      redirect_to albums_path
    else
      render action: 'new'
    end
  end

  def show
    @album = user_albums.find( params[:id] )
    @cover_size = params[:cover_size] if params[:cover_size]
  end

  def edit
    @album = user_albums.find( params[:id] )
  end

  def update
    @album = user_albums.find( params[:id] )

    if @album.update_attributes(params[:album])
      redirect_to albums_path, notice: 'Album saved!'
    else
      render action: 'edit'
    end
  end

  def destroy
    @album = user_albums.find( params[:id] )
    if @album.destroy
      redirect_to albums_path, notice: 'Album removed!'
    else
      render 'show'
    end
  end

  def search
    @albums = Album.search(params[:q], current_user)
    render 'index'
  end

  private
    def user_albums
      current_user.albums
    end

end
