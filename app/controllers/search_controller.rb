class SearchController < ApplicationController
  def search
    query = params[:search_posts].presence && params[:search_posts][:query]
    @posts = Post.search_post(query) if query
  end
end
