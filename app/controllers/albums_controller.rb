class AlbumsController < ApplicationController
  before_filter :login_required

  def new
    @album = current_user.albums.new
  end

  def index
    @albums = current_user.albums
  end

  def create
    @album = current_user.albums.new(params[:album])
    if @album.save
      redirect_to albums_path
    else
      render action: 'new'
    end
  end

end
