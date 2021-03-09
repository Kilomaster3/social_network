class Account::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @account = Account.from_omniauth(request.env['omniauth.auth'])

    if @account.persisted?
      sign_in_and_redirect @account, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_account_profile_url
    end
  end

  def failure
    redirect_to root_path
  end
end
