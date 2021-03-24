class ActivitiesController < AccountBaseAuthController
  def index
    updated_versions_ids = PaperTrail::Version.where(event: 'update').map{ |version| version.reify.account_id }.uniq
    followers = current_account.following.where(id: updated_versions_ids)
    followers_ids = followers.pluck(:id)
    result = []
    PaperTrail::Version.where(event: 'update').each do |version|
      if followers_ids.include?(version.reify.account_id)
        follower = followers.where(id: version.reify.account_id).first
        result << { follower => version }
      end
    end

    comments_ids = PaperTrail::Version.where(event: 'create', item_type: 'Comment').pluck(:item_id)
    likes_ids = PaperTrail::Version.where(event: 'create', item_type: 'Like').pluck(:item_id)

    @comments = Comment.joins(:account, :post).where.not(account_id: current_account.id).where(id: comments_ids)
    @likes = Like.joins(:account, :post).where.not(account_id: current_account.id).where(id: likes_ids)
    @versions = result
  end
end
