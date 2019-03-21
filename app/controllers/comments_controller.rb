class CommentsController < ApplicationController

  def create
    # comment = Comment.new(comment_params)
    comment = current_or_guest_user.comments.create!(comment_params)
    user = User.find(comment.user_id)
    if comment.save
    #render json: comment.comment_text
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
    render json: comment
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :album_id, :comment_text)
  end

end
