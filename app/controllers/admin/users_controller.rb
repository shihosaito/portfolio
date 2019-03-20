class Admin::UsersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @users = User.with_deleted.all
  end

  def show
    @user = User.find(params[:id])
    @albums = Album.where(user_id: params[:id])
  end

  def edit
  end

  def destroy
    user = User.find(params[:id])
    user.delete
    redirect_to admin_users_path
    flash[:notice] = "ユーザーを削除しました"
  end
end
