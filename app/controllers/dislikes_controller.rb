# frozen_string_literal: true

class DislikesController < AccountBaseAuthController
  before_action :find_post
  before_action :find_dislike, only: [:destroy]
  include State

  def index
    @dislike = Dislike.includes(:account).all
  end

  def create
    if dislike_already_state?
      render json: { error: 'Already Taken' }, status: :unprocessable_entity
    else
      @post.dislikes.create(account_id: current_account.id)
      render json: { dislikes_count: @post.dislikes.count }
    end
  end

  def destroy
    if dislike_already_state?
      flash[:notice] = 'Cannot unlike'
    else
      @dislike.destroy
    end
    redirect_to post_path(@post)
  end

  private

    def find_post
      @post = Post.find(params[:post_id])
    end

    def find_dislike
      @dislike = @post.dislikes.find(params[:id])
    end
end
