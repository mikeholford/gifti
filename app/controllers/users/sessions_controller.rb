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
    if @user.present?
      if @user.confirmed?
        @user.update(login_key: SecureRandom.hex, login_key_sent: Time.now)
        UserLoginMailer.send_magic_link(@user).deliver_later
        redirect_to root_path, notice: "A Magic Link has been sent to you email. Click it to login!"
        # super
      else
        redirect_to new_user_confirmation_path, alert: "You need to confirm your account"
      end
    else
      redirect_to new_user_registration_path, alert: "Please sign up"
    end
  end

  def magic_login
    key = params[:key]
    user = User.find_by_login_key(key)
    if user.confirmed?
      unless user_signed_in?
        if user.present?
          if user.login_key_sent.present?
            if user.login_key_sent > Time.now - 900
              sign_in(user)
              user.update(login_key_sent: nil)
              redirect_to root_path, notice: "MAGIC! You've been signed in 💫"
            else
              reject_magic_login
            end
          else
            reject_magic_login
          end
        else
          reject_magic_login
        end
      else
        redirect_to root_path, alert: "Already signed in"
      end
    else
        redirect_to new_user_session_path, alert: "You need to confirm your account first"
    end
  end

  def reject_magic_login
    redirect_to root_path, alert: "Access Denied"
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
