class Admin::CommentsController < ApplicationController

  before_action :authenticate_admin!

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_back(fallback_location: admin_album_path)
  end

end
