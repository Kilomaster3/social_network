# frozen_string_literal: true

class ActivitiesController < AccountBaseAuthController
  def index
    @activities = PublicActivity::Activity.order('created_at desc').where(
      owner_id: current_account.followers, owner_type: 'Account'
    )
    @likes = Like.where(id: PublicActivity::Activity.where(trackable_type: 'Like').select(:trackable_id))
    authorize @activities, policy_class: PublicActivity::ActivitiesPolicy
    authorize @likes, policy_class: PublicActivity::ActivitiesPolicy
  end
end
