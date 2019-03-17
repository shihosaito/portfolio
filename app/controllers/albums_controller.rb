class AlbumsController < ApplicationController



  def index
  end

  def show
    @album = Album.find(params[:id])
    @photo = Photo.new
    @photos = Photo.where(album_id: params[:id]).order(:image_number)
    @comment = Comment.new
    @comments = Comment.where(album_id: params[:id]).reverse_order
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

  def edit
    @album = Album.find(params[:id])
    @photos = Photo.where(album_id: params[:id]).order(:image_number)
  end

  def update
    album = Album.find(params[:id])
    if album.user_id == current_user.id
      album.update(album_params)
      redirect_to edit_album_path(album.id)
    else
      redirect_to root_path
    end
  end

  def destroy
    album = Album.find(params[:id])
    album.destroy
    redirect_to user_path(current_user.id)
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
