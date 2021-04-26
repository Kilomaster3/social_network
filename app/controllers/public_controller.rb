class PublicController < ApplicationController
  def home
    if current_account
      @accounts = Account.where.not(id: current_account.id)
      @posts = params[:tag] ? Post.includes(:account).tagged_with(params[:tag]) : Post.includes(:account).all
      @friends_posts = Post.where(account_id: current_account.following.pluck(:id))
      @activities = PublicActivity::Activity.order('created_at desc').where(owner_id: current_account.followers, owner_type: 'Account')
      @likes = Like.where(id: PublicActivity::Activity.where(trackable_type: 'Like').pluck(:trackable_id))
      @possibile_friends = Account.where.not(id: current_account.followers.pluck(:id))
      @recent_posts = Post.recent
      @oldest_posts = Post.oldest
      @search_last_posts = Post.search_last_post
    end
  end
end
