class Admin::PhotosController < ApplicationController

  before_action :authenticate_admin!

  def show
  end

  def edit
  end

  def destroy
    photo = Photo.find(params[:id])
    photo.destroy
    redirect_to admin_album(photo.album_id)
  end

end
