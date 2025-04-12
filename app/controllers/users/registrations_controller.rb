# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # Override the create action
  def create
    # Extract company_name from parameters, others are handled by build_resource
    company_name = sign_up_params[:company_name]
    user_params = sign_up_params.except(:company_name)

    # Use a transaction to ensure both User and Company are created or neither
    ActiveRecord::Base.transaction do
      # Create the company first
      @company = Company.new(name: company_name)
      # You might want to add validations to the Company model (e.g., presence of name)
      unless @company.save
        # If company save fails, add its errors to the user resource
        # so they are displayed on the form by devise/shared/error_messages
        build_resource(user_params)
        @company.errors.full_messages.each do |msg|
          resource.errors.add(:company_name, msg.sub(/^Name /, ' ')) # Prepend with field name
        end
        # Prevent user save attempt and render the form again
        raise ActiveRecord::Rollback
      end

      # Now build the user resource using permitted parameters (Devise helper)
      build_resource(user_params)
      # Associate the user with the newly created company
      resource.company = @company

      # Attempt to save the user
      resource.save
      yield resource if block_given?

      if resource.persisted?
        # User and Company saved successfully
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        # User save failed (e.g., password mismatch, email taken)
        # Company creation will be rolled back by the transaction
        # Clean up the resource (user) to avoid partial state
        clean_up_passwords resource
        set_minimum_password_length
        # Errors from user validation are already on `resource.errors`
        # Re-render the form
        # Note: We don't need respond_with here as we raised Rollback if company failed
        # If user save fails, Devise default behavior handles rendering
        # Ensure we have the company name available if we render again
        resource.company_name = company_name # Assign virtual attribute if needed
        raise ActiveRecord::Rollback # Ensure rollback if user save fails
      end
    end # End transaction

  # Rescue from Rollback to render the new template if transaction failed
  rescue ActiveRecord::Rollback
    # Need to rebuild resource if company creation failed earlier
    build_resource(user_params) unless resource.present?
    resource.company_name = company_name # Ensure company name persists on form
    clean_up_passwords resource
    set_minimum_password_length
    respond_with resource # Renders the 'new' template with errors
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
