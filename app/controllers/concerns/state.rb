module State
  extend ActiveSupport::Concern

  included do
    def already_state?
      Like.where(account_id: current_account.id, post_id: params[:post_id]).exists?
      Dislike.where(account_id: current_account.id, post_id: params[:post_id]).exists?
    end
  end
end
