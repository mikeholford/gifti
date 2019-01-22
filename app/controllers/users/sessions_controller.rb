# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    @user = User.where(:email => params[:user][:email])[0] # you get the user now
    if @user.confirmed?
      super
    else
      redirect_to new_voucher_path
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # def after_sign_in_path_for(resource)
  #   if resource.sign_in_count == 1
  #      new_voucher_path
  #   else
  #      root_path
  #   end
  # end
end
