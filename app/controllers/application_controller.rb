class ApplicationController < ActionController::Base
  before_action :configure_devise, if: :devise_controller?

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_index_path
  end
  private

  def configure_devise
    devise_parameter_sanitizer.permit(:user_update, keys: [:first_name, :last_name, images: [] ])
  end
end
