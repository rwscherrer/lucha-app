class Client::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
	
  def after_sign_up_path_for(client)
    client_edit_path(client)
  end

  def create
    build_resource(sign_up_params)
    add_iv_values(resource)
    encrypt_sign_up_params(resource)

    resource.save
    yield resource if block_given?
    if resource.persisted?
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
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

	protected

  def add_iv_values(resource)
    resource.encrypted_ssn_iv = SecureRandom.base64
    resource.encrypted_estimated_household_income_iv = SecureRandom.base64
    resource.encrypted_disability_iv = SecureRandom.base64
    resource.encrypted_email_iv = SecureRandom.base64
    resource.encrypted_address_iv = SecureRandom.base64
    resource.encrypted_home_phone_iv = SecureRandom.base64
    resource.encrypted_work_phone_iv = SecureRandom.base64
    resource.encrypted_cell_phone_iv = SecureRandom.base64
  end

  def encrypt_sign_up_params(resource)
    resource.email = Client.encrypt_email(sign_up_params[:encrypted_email], iv: resource.encrypted_email_iv)
    resource.home_phone = Client.encrypt_home_phone(sign_up_params[:encrypted_home_phone], iv: resource.encrypted_home_phone_iv)
    resource.cell_phone = Client.encrypt_cell_phone(sign_up_params[:encrypted_cell_phone], iv: resource.encrypted_cell_phone_iv)
    resource.address = Client.encrypt_address(sign_up_params[:encrypted_address], iv: resource.encrypted_address_iv)
  end
	
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |client_params|
      client_params.permit(:first_name, 
          :last_name, 
          :encrypted_email, 
          :authorization_and_waiver, 
          :privacy_policy_authorization, 
          :race,
          :sex,
          :encrypted_home_phone,
          :encrypted_work_phone,
          :encrypted_cell_phone,
          :encrypted_address,
          :state,
          :city,
          :zip_code,
          :ward,
          :encrypt_ssn,
          :preferred_contact_method,
          :preferred_language,
          :dob,
          :head_of_household,
          :num_in_household,
          :num_of_dependants,
          :education_level,
          :encrypted_disability,
          :union_member,
          :military_service_member,
          :volunteer_interest,
          :encrypted_estimated_household_income,
          :authorization_and_waiver,
          :privacy_policy_authorization,
          :password,
          :password_confirmation)
    end
	end

  def set_flash_message!(key, kind, options = {})
    if is_flashing_format?
      set_flash_message(key, kind, options)
    end
  end
end
