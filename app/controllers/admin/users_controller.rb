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
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to admin_user_path(user.id)
    else
      flash[:notice] = "入力に誤りがあります"
    end
  end

  def destroy
    user = User.find(params[:id])
    user.delete
    redirect_to admin_users_path
    flash[:notice] = "ユーザーを削除しました"
  end

  private
  def user_params
    params.require(:user).params(:name, :email, :password, :password_confirmation)
  end
end
