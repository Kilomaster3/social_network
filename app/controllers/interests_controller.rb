class InterestsController < ApplicationController
  before_action :find_user

  def edit; end

  def update
    if @account.update(account_params)
      flash[:success] = 'Interests updated'
      redirect_to root_path
    else
      flash[:alert] = 'Interests could not be updated.'
      render :edit
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
