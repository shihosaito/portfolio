class CommentsController < ApplicationController

  def create
    comment = Comment.new(comment_params)
    user = User.find(comment.user_id)
    if comment.save
    #render json: comment.comment_text
      respond_to do |f|
        f.json { render json: {comment:comment, user: user}}
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :album_id, :comment_text)
  end

end
