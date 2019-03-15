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
  end
end
