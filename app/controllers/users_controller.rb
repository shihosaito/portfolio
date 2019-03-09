class UsersController < ApplicationController

  def show
    @user = current_user
    @album = Album.new
    @albums = @user.album
  end

  def edit
  end

end
