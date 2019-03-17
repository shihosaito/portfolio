class PhotosController < ApplicationController

  before_action :authenticate_user!

  def create
    photo = Photo.new(photo_params)
    if photo.save
      redirect_to album_path(photo.album_id)
    end
  end

  def update
    photo = Photo.find(params[:id])
    photo.update(photo_params)
    redirect_to edit_album_path(photo.album_id)
  end

  def destroy
    photo = Photo.find(params[:id])
    photo.destroy
    redirect_to edit_album_path(photo.album_id)
  end



  private
  def photo_params
    params.require(:photo).permit(:image, :image_number, :album_id)
  end


end
