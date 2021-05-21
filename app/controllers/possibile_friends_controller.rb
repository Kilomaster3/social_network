# frozen_string_literal: true

class PossibileFriendsController < AccountBaseAuthController
  def index
    @account = Account.where.not(id: current_account.id)
    @possibile_friends = Account.paginate(page: params[:page], per_page: 4)
                                .where.not(id: current_account.followers.pluck(:id)).where.not(id: current_account.id)
  end
end
