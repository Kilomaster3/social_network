# frozen_string_literal: true

class ActivitiesController < AccountBaseAuthController
  def index
    @activities = PublicActivity::Activity.paginate(page: params[:page], per_page: 4).order('created_at desc').where(owner_id: current_account.following,
                                                                          owner_type: 'Account').includes(:owner, :trackable)
    @likes = Like.where(id: PublicActivity::Activity.where(trackable_type: 'Like').select(:trackable_id))
    authorize @activities, policy_class: PublicActivity::ActivitiesPolicy
    authorize @likes, policy_class: PublicActivity::ActivitiesPolicy
  end
end
