# frozen_string_literal: true

class Account::ProfilesController < AccountBaseAuthController
  def index
    @account ||= current_account
    @friends = current_account.friends
  end

  def show
    @posts = current_account.posts
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

  private

  def account_params
    params.require(:account).permit(:email, :first_name, :last_name, :avatar)
  end
end
