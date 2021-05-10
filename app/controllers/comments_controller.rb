# frozen_string_literal: true

class CommentsController < AccountBaseAuthController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to posts_path(@comment.post)
    else
      render :new
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :account_id, :post_id)
    end
end
