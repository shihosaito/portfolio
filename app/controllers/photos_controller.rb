class PhotosController < ApplicationController

  before_action :authenticate_user!

  def create
    photo = Photo.new(photo_params)
    if photo.save
      redirect_to album_path(photo.album_id)
      flash[:notice] = "写真を追加しました"
    else
      redirect_to album_path(photo.album_id)
      flash[:notice] = "写真を追加できませんでした"
    end
  end

  def update
    photo = Photo.find(params[:id])
    if photo.update(photo_params)
      redirect_to edit_album_path(photo.album_id)
      flash[:notice] = "写真情報を変更しました"
    else
      redirect_to edit_album_path(photo.album_id)
      flash[:notice] = "写真情報を変更できませんでした"
    end
  end

  def destroy
    photo = Photo.find(params[:id])
    photo.destroy
    redirect_to edit_album_path(photo.album_id)
    flash[:notice] = "写真を削除しました"
  end

  private
  def photo_params
    params.require(:photo).permit(:image, :image_number, :album_id)
  end


end
