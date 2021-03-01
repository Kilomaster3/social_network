# frozen_string_literal: true

class Account::ProfilesController < AccountBaseAuthController
  def show
    @posts = current_account.posts
  end

  def new
    @account = Account.new
  end

  def update
    if current_account.update_attributes(user_params)
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

  def user_params
    params.require(:account).permit(:email, :password, :password_confirmation, :first_name, :last_name, :avatar)
  end
end
