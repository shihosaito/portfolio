class HomesController < ApplicationController

  def index
  end

  def about
  end

  def guest
    guest_user
    redirect_to albums_path
  end
end
