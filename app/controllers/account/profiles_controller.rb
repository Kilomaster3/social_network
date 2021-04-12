# frozen_string_literal: true

class Account::ProfilesController < AccountBaseAuthController
  def index
    @account ||= Account.find_by(id: params[:id])
    @account_interests = @account.interests.all
  end

  def show
    @account = Account.find_by(id: params[:id])
    @interests_match_percentage = (@account.interests & current_account.interests).count.to_f / (@account.interests | current_account.interests).count * 100
  end

  def new
    @account = Account.new
  end

  def update
    if current_account.update_attributes(account_params)
      flash[:success] = 'Profile complete'
      redirect_url = account_profile_path(current_account)
    else
      redirect_url = account_profile_path(current_account)
    end
    redirect_to redirect_url
  end

  def edit
    @account = Account.find(params[:id])
  end

  def following
    @account = Account.find(params[:id])
    @accounts = @account.following
    render 'account/follows/show_friends'
  end

  def followers
    @account = Account.find(params[:id])
    @accounts = @account.followers
    render 'account/follows/show_followers'
  end

  private

  def account_params
    params.require(:account).permit(:email, :first_name, :last_name, :avatar, { interest_ids: [] }, :interest_ids)
  end
end
