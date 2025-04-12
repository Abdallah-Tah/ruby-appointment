class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource

  protected # Use protected, standard Devise convention

  def configure_permitted_parameters
    # For sign up, permit email, password, password_confirmation, and company_name
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :company_name])

    # You might need to permit parameters for account update later:
    # devise_parameter_sanitizer.permit(:account_update, keys: [:attribute1, :attribute2])
  end

  private

  def layout_by_resource
    if devise_controller?
      'devise' # Use app/views/layouts/devise.html.erb for Devise controllers
    else
      'application' # Use app/views/layouts/application.html.erb for others
    end
  end
end
