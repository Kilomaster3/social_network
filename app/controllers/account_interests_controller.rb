# frozen_string_literal: true

class AccountInterestsController < AccountBaseAuthController
  before_action :find_user
  include AccountInterests

  def index
    @categories = Category.includes(:interests).all
    @account_interests = current_account.interests.all
  end

  def edit; end

  def update
    if @account.update(account_params)
      flash[:success] = 'Interests updated'
    else
      flash[:alert] = 'Interests could not be updated.'
    end

    respond_to do |format|
      format.json
    end
  end

  def connection
    @all_accounts = Account.where.not(id: current_account.id).includes(:accounts_interests, :interests)

    data = @all_accounts.map do |account|
      interests = (account.interests & current_account.interests).count.to_f / (account.interests |
        current_account.interests).count * 100
      full_name_path = "<a href='#{account_profile_path(account)}'>#{account.full_name}</a>"
      { account_id: account.id,
        full_name_path: full_name_path,
        interests: interests }
    end
    render json: data.select { |d| d[:interests] >= 40 }
  end

  private

    def find_user
      @account = current_account
    end

    def account_params
      params.require(:account).permit(interest_ids: [])
    end
end
