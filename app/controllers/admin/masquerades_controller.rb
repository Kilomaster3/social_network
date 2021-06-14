# frozen_string_literal: true

module Admin
  class MasqueradesController < Devise::MasqueradesController

    def after_masquerade_path_for(*)
      posts_path
    end

    def after_back_masquerade_path_for(*)
      admin_accounts_path
    end
  end
end
