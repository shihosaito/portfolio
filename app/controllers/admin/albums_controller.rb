class Admin::AlbumsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
    @photos = Photo.where(album_id: params[:id]).order(:image_number)
    @comments = Comment.where(album_id: params[:id]).reverse_order
    respond_to do |f|
      f.html
      f.json { render json: Comment.where( 'id > ?', params[:comment][:id] ) }
    end
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
