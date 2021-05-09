# frozen_string_literal: true

module State
  extend ActiveSupport::Concern

  included do
    def already_state?
      Like.exists?(account_id: current_account.id, post_id: params[:post_id])
      Dislike.exists?(account_id: current_account.id, post_id: params[:post_id])
    end
  end
end
