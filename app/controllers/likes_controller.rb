# frozen_string_literal: true

class LikesController < AccountBaseAuthController
  before_action :find_post
  before_action :find_like, only: [:destroy]
  include State

  def index
    @like = Like.includes(:account).all
  end

  def create
    if already_state?
      flash[:alert] = "You can't like more than once"
    else
      @post.likes.create(account_id: current_account.id)
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    if already_state?
      flash[:notice] = 'Cannot unlike'
    else
      @like.destroy
    end
    redirect_to post_path(@post)
  end

  private

    def find_post
      @post = Post.find(params[:post_id])
    end

    def find_like
      @like = @post.likes.find(params[:id])
    end
end
