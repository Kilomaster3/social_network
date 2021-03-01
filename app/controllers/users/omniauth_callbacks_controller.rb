module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def twitter
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
      else
        session["devise.twitter_data"] = request.env["omniauth.auth"].except(:extra)
        redirect_to new_account_registration_url
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
