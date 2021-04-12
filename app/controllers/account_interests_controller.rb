class AccountInterestsController < ApplicationController
  before_action :find_user

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

  private

  def find_user
    @account = current_account
  end

  def account_params
    params.require(:account).permit(interest_ids: [])
  end
end

