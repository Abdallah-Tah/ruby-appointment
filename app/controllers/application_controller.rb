class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  layout :layout_by_resource

  private

  def layout_by_resource
    if devise_controller?
      'devise' # Use app/views/layouts/devise.html.erb for Devise controllers
    else
      'application' # Use app/views/layouts/application.html.erb for others
    end
  end
end
