class SearchController < ApplicationController
  def search
    if params[:term].nil?
      @posts = []
    else
      term = params[:term]
      @posts = Post.search term, filds: [:content], highlight: true
    end
  end

  def typeahead
    render json: Post.search(params[:term]).map do |post| { title: post.title, value: post.id } end
  end
end
