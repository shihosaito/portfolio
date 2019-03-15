class Admin::AlbumsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
    @photos = Photo.where(album_id: params[:id])
    @comments = Comment.where(album_id: params[:id])
  end

  def edit
  end

  def update
    album = Album.find(params[:id])
    album.update
    redirect_to admin_album_path(album.id)
  end

  def destroy
    album = Album.find(params[:id])
    album.destroy
    redirect_to album_user_path(album.user_id)
  end

end
