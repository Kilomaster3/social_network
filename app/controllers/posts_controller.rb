# frozen_string_literal: true

class PostsController < AccountBaseAuthController
  before_action :find_post, only: %i[show edit update destroy]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 4).includes(:account, :taggings, :tags, comments: :account)
                 .order('created_at desc').where(private: false)
    authorize @posts
  end

  def show; end

  def new
    @post = Post.new
    @post.tags.build
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

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post updated'
      redirect_to activities_path
    else
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Post deleted'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'Post were not deleted'
    end
  end

  def search_last
    @posts = Post.paginate(page: params[:page], per_page: 4).search_last_post.includes(:account, :comments, :taggings, :tags)
    render action: :index
  end

  def most_comments
    @posts = Post.paginate(page: params[:page], per_page: 4).most_comments.includes(:account, :taggings, :tags, comments: :account)
    render action: :index
  end

  def most_likes
    @posts = Post.paginate(page: params[:page], per_page: 4).most_likes.includes(:account, :comments, :taggings, :tags)
    render action: :index
  end

  def friends_post
    @posts = Post.paginate(page: params[:page],
                           per_page: 4).where(account_id: current_account.following.pluck(:id))
                 .includes(:account, :comments, :taggings, :tags).private_post
    render action: :index
  end

  private

    def find_post
      @post = Post.find(params[:id])
      authorize @post
    end

    def post_params
      params.require(:post).permit(:title, :content, :image, :published_at, :status, :private,
                                   tags_attributes: [:name]).merge(account: current_account)
    end
end
