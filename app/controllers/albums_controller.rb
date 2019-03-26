class AlbumsController < ApplicationController

 before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]

  def show
    @album = Album.find(params[:id])
    @photo = Photo.new
    @photos = Photo.where(album_id: params[:id]).order(:image_number)
    @comment = Comment.new
    @comments = Comment.where(album_id: params[:id]).reverse_order

    respond_to do |f|
      f.html
      f.json {
        # comments = Comment.joins(:user).select('comments.*, users.name').where('comments.id > ?', params[:comment][:id])
        comments = Comment.joins(:user).select('comments.*, users.name').where(id: params[:comment][:id])
        delete_comments = Comment.only_deleted.where(album_id: params[:id])
        render json: { comments:comments, deleted_comments: delete_comments }
      }
    end

    # respond_to do |f|
    #   f.html
    #   f.json { render json: Comment.where( 'id > ?', params[:comment][:id] ) }
    # end
  end

  def create
    album = Album.new(album_params)
    album.user_id = current_user.id
    if album.save
      redirect_to album_path(album.id)
      flash[:notice] = "新しいアルバムを作成しました"
    else
      redirect_back(fallback_location: user_path)
      flash[:notice] = "入力に誤りがあります"
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
      flash[:notice] = "アルバム詳細を変更しました"
    else
      redirect_to edit_album_path(album.id)
      flash[:notice] = "入力に誤りがあります"
    end
  end

  def destroy
    album = Album.find(params[:id])
    album.destroy
    redirect_to user_path(current_user.id)
    flash[:notice] = "アルバムを削除しました"
  end



  def login
    album = Album.find_by(album_name: params[:album][:album_name], user_id: params[:album][:user_id])
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
