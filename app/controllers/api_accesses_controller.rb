class ApiAccessesController < ApplicationController

  before_action :authenticate_user!, except: [:documentation]

  def new
    @api_access = ApiAccess.new
  end

  def documentation
  end

  def create
    @api_access = ApiAccess.new(api_access_params.merge(:user_id => current_user.id))
    respond_to do |format|
      if @api_access.save
        format.html { redirect_to new_api_access_path, notice: 'Access granted 😊' }
      else
        format.html { render :new, alert: 'Please try again...' }
      end
    end
  end

  private

  def api_access_params
    params.require(:api_access).permit(:name, :website_url, :description, :user_id)
  end

end
