class DislikesController < AccountBaseAuthController
  before_action :find_post
  before_action :find_dislike, only: [:destroy]
  include State

  def index
    @dislike = Dislike.includes(:account).all
  end

  def create
    if already_state?
      flash[:alert] = "You can't dislike more than once"
    else
      @post.dislikes.create(account_id: current_account.id)
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    if already_state?
      flash[:notice] = "Cannot unlike"
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
    @dislike = @post.likes.find(params[:id])
  end
end
