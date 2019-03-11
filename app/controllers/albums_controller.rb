class AlbumsController < ApplicationController
  def show
    @album = Album.find(params[:id])
    @photo = Photo.new
    @photos = Photo.where(album_id: params[:id])
    @comment = Comment.new
    @comments = Comment.where(album_id: params[:id])
  end

  def create
    album = Album.new(album_params)
    album.user_id = current_user.id
    if album.save
      redirect_to album_path(album.id)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
  end

  def edit
  end

  def login
    album = Album.find_by(album_name: params[:album][:album_name])
    if album && album.authenticate(params[:album][:password_digest])
      #authenticate paramsで持ってきたデータと一致してるかみる
      album_log_in album
      redirect_to album
    end
  end

  def logout
  end

  private
  def album_params
    params.require(:album).permit(:album_name, :album_password, :password, :password_confirmation)
  end

end
