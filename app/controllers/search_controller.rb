# frozen_string_literal: true

class SearchController < AccountBaseAuthController
  def search
    query = params[:search_posts].presence && params[:search_posts][:query]
    @posts = Post.search_post(query) if query
  rescue Faraday::ConnectionFailed
    @posts = Post.search(params[:term])
    render json: @posts.map(&:title).uniq
  end
end
