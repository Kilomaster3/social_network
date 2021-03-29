class ActivitiesController < AccountBaseAuthController
  def index
    @activities = PublicActivity::Activity.order('created_at desc').where(owner_id: current_account.followers, owner_type: 'Account')
    @likes = Like.where(id: PublicActivity::Activity.where(trackable_type: 'Like').pluck(:trackable_id))
  end
end
