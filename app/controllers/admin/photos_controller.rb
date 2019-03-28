class Admin::PhotosController < ApplicationController

  before_action :authenticate_admin!

  def destroy
    photo = Photo.find(params[:id])
    photo.destroy
    redirect_to admin_album_path(photo.album_id)
  end

end
