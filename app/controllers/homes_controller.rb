class HomesController < ApplicationController
  def index
  end

  def guest
    guest_user
    redirect_to root_path
  end
end
