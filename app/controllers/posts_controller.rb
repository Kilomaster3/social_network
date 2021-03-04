class PostsController < AccountBaseAuthController
  def index
    @posts = params[:tag] ? Post.tagged_with(params[:tag]) : Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :tag_list, :tag, { tag_ids: [] }, :tag_ids).merge(account: current_account)
  end
end
