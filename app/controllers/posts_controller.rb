class PostsController < AccountBaseAuthController
  before_action :find_post, only: %i[show edit update destroy]

  def index
    @posts = params[:tag] ? Post.tagged_with(params[:tag]) : Post.all
  end

  def show; end

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

  def edit; end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = 'Post updated'
      redirect_to activities_path
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :tag_list, :tag, { tag_ids: [] }, :tag_ids).merge(account: current_account)
  end
end
