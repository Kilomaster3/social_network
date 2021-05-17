# frozen_string_literal: true

class PublicController < ApplicationController
  def home
    return unless current_account

    @accounts = Account.where.not(id: current_account.id)
    @posts = Post.paginate(page: params[:page], per_page: 4).includes([:account]).includes([:comments]).includes([:tags]).order('created_at desc')
    @friends_posts = Post.paginate(page: params[:page],
                                   per_page: 4).where(account_id: current_account.following.pluck(:id)).includes([:account])
                         .includes([:comments])
    @activities = PublicActivity::Activity.order('created_at desc').where(owner_id: current_account.followers,
                                                                          owner_type: 'Account').includes([:owner]).includes([:trackable])
    @likes = Like.where(id: PublicActivity::Activity.where(trackable_type: 'Like').select(:trackable_id))
    @possibile_friends = Account.paginate(page: params[:page],
                                          per_page: 4).where.not(id: current_account.followers.pluck(:id)).where.not(id: current_account.id)
  end
end
