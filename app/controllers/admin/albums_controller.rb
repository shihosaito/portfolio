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
      f.json {
        comments = Comment.joins(:user).select('comments.*, users.name').where('comments.id > ?', params[:comment][:id]).where(album_id: @album.id)
        delete_comments = Comment.only_deleted.where(album_id: @album.id)
        render json: { comments:comments, deleted_comments: delete_comments }
      }
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

  # def destroy_all
  #   users = User.where('created_at < ?', 1.week.ago )
  # end

end
