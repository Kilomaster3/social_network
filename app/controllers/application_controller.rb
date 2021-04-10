class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  helper_method :resource_name, :resource, :devise_mapping, :resource_class

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

  def after_sign_in_path_for(resource)
    if resource.interests.any?
      root_path
    else
      account_interest_path
    end
  end
end

