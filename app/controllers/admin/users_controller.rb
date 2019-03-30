class Admin::UsersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @users = User.all
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
    user.destroy
    user.update(email: user.deleted_at.to_i.to_s + '_' + user.email.to_s)
    redirect_to admin_users_path
    flash[:notice] = "ユーザーを削除しました"
  end

  def destroy_all
    start_time = Time.zone.local(2019, 3, 1, 00, 00, 00) #(2019年, 11月, 29日, 11時, 22分, 33秒)
    users = User.where(created_at: start_time..1.week.ago).where(guest: "true")
    users.destroy_all
    redirect_to admin_users_path
    flash[:notice] = "ユーザーを削除しました"
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
