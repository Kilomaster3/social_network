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
      render json: { error: 'Already Taken' }, status: :unprocessable_entity
    else
      @post.likes.create(account_id: current_account.id)
      render json: { likes_count: @post.likes.count }
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
