class AlbumsController < ApplicationController
  before_filter :login_required
  before_filter :populate_instance_variable, :except => [:index, :search]

  attr_accessor :new, :show, :edit

  def index
    @albums = current_user.albums
  end

  def create
    if @album.save
      redirect_to albums_path
    else
      render action: 'new'
    end
  end

  def update
    if @album.update_attributes(params[:album])
      redirect_to albums_path, notice: 'Album saved!'
    else
      render action: 'edit'
    end
  end

  def destroy
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
    def populate_instance_variable
      if params[:id].present?
        @album = current_user.albums.find( params[:id] )
        @cover_size = params[:cover_size] if params[:cover_size]
      else
        @album = current_user.albums.new(params[:album])
      end
    end

end
