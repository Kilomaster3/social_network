# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  include Pundit
  before_action :masquerade!
  before_action :set_locale
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  helper_method :resource_name, :resource, :devise_mapping, :resource_class
  protect_from_forgery with: :exception

  def resource_name
    :account
  end

  def resource
    @resource ||= Account.new
  end

  def resource_class
    Account
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:account]
  end

  def pundit_user
    current_account
  end

  def after_sign_in_path_for(resource)
    if resource.interests.any?
      posts_path
    else
      account_interests_path
    end
  end

  def user_not_authorized(exception)
    flash[:alert] = exception.policy.try(:error_message) || 'You do not have such rights'

    redirect_to root_path
  end

  private

    def set_locale
      I18n.locale = extract_locale || I18n.default_locale
    end

    def extract_locale
      parsed_locale = params[:locale]
      I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
    end

    def default_url_options
      { locale: I18n.locale }
    end
end
