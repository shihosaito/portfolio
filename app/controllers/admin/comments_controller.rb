class Admin::CommentsController < ApplicationController

  before_action :authenticate_admin!

 def create
  user = current_admin
  comment = Comment.new(comment_params)
  comment.user_id = current_admin.id
  if comment.save
    respond_to do |f|
      f.json { render json: {comment:comment, user: user}}
    end
  else
    redirect_back(fallback_location: album_path)
    flash[:notice] = "コメントを投稿できませんでした"
  end
 end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_back(fallback_location: admin_album_path)
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :album_id, :comment_text)
  end
end
