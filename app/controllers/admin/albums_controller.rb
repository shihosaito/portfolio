class Admin::AlbumsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
    @photos = Photo.where(album_id: params[:id]).order(:image_number)
    @comment = Comment.new
    @comments = Comment.where(album_id: params[:id]).reverse_order
    respond_to do |f|
      f.html
      f.json {
        comments = Comment.joins(:user).select('comments.*, users.name').where('comments.id > ?', params[:comment][:id]).where(album_id: @album.id)
        delete_comments = Comment.only_deleted.where(album_id: @album.id)
        render json: { comments:comments, deleted_comments: delete_comments }
      }
    end
  end

  def update
    album = Album.find(params[:id])
    album.update(album_params)
    redirect_to admin_album_path(album.id)
  end

  def destroy
    album = Album.find(params[:id])
    album.destroy
    redirect_to admin_user_path(album.user_id)
  end

  private
  def album_params
    params.require(:album).permit(:album_name, :password, :password_confirmation)
  end

end
