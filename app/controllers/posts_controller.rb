class PostsController < AccountBaseAuthController
  before_action :find_post, only: %i[show edit update destroy]

  def index
    @posts = params[:tag] ? Post.includes(:account).tagged_with(params[:tag]) : Post.includes(:account).all
    authorize @posts
  end

  def show; end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    authorize @post
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit ;end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = 'Post updated'
      redirect_to activities_path
    else
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = 'Post deleted'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'Post were not deleted'
    end
  end

  def recent
    @posts = Post.recent
    render action: :index
  end

  def oldest
    @posts = Post.oldest
    render action: :index
  end

  def search_last
    @posts = Post.search_last_post
    render action: :index
  end

  def most_comments
    @posts = Post.most_comments
    render action: :index
  end

  def most_likes
    @posts = Post.most_likes
    render action: :index
  end

  def search
    query = params[:search_posts].presence && params[:search_posts][:query]
    @posts = Post.search_post(query) if query
  end

  private

  def find_post
    @post = Post.find(params[:id])
    authorize @post
  end

  def post_params
    params.require(:post).permit(:title, :content, :image, :tag_list, :tag, { tag_ids: [] }, :tag_ids).merge(account: current_account)
  end
end
