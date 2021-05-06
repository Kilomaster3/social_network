class PublicController < ApplicationController
  def home
    if current_account
      @accounts = Account.where.not(id: current_account.id)
      @posts = Post.paginate(page: params[:page], per_page: 4).includes([:account])
      @friends_posts = Post.paginate(page: params[:page], per_page: 4).where(account_id: current_account.following.pluck(:id)).includes([:account])
      @activities = PublicActivity::Activity.order('created_at desc').where(owner_id: current_account.followers,
                                                                            owner_type: 'Account').includes([:owner]).includes([:trackable])
      @likes = Like.where(id: PublicActivity::Activity.where(trackable_type: 'Like').pluck(:trackable_id))
      @possibile_friends = Account.where.not(id: current_account.followers.pluck(:id)) && Account.where.not(id: current_account.id)
    end
  end
end
