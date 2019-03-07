class AlbumsController < ApplicationController
  def show
    @photo = Photo.new
    @photos = Photo.where(params[:id])
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
  end

  private
  def album_params
    params.require(:album).permit(:album_name, :album_password)
  end

end
