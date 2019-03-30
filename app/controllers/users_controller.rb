class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = current_user
    @album = Album.new
    @albums = @user.album
  end

  def destroy
    user = User.find(params[:id])
    user.delete
    user.update(email: user.deleted_at.to_i.to_s + '_' + user.email.to_s)
    redirect_to root_path
  end

end
