# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource)
    resource.sign_in_count == 1 ? new_voucher_path : root_path
    # token = resource.send(:set_reset_password_token)
    # edit_password_url(resource, reset_password_token: token)
  end
end
