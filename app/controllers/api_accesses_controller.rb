class ApiAccessesController < ApplicationController
  # before_action :set_api_access, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, only: [:new]

  def new
    @api_access = ApiAccess.new
  end

  def documentation
  end

  #
  # def index
  #   redirect_to new_api_access_path
  # end
  #
  # def show
  #   @api_access = ApiAccess.find(params[:id])
  # end
  #
  # def capture
  #   if params[:key].present?
  #     @user = User.find_by_secret_key(params[:key])
  #     if @user.present?
  #       @api_access = ApiAccess.find(params[:id])
  #     else
  #       redirect_to '/'
  #     end
  #   else
  #     redirect_to '/'
  #   end
  # end
  #
  # def schedule
  #   @api_access = ApiAccess.find(params[:id])
  # end
  #
  # def success_schedule
  #   @api_access = ApiAccess.find(params[:id])
  #   redirect_to schedule_api_access_path if @api_access.scheduled == false
  # end
  #
  #
  # def new
  #   if params[:design].present?
  #     @design = Design.where(template: params[:design]).last
  #     if @design.present?
  #       @api_access = ApiAccess.new
  #     else
  #       redirect_to designs_path
  #     end
  #   else
  #     redirect_to designs_path
  #   end
  # end
  #
  #
  # def edit
  # end
  #
  #
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
  #
  # # PATCH/PUT /api_accesss/1
  # # PATCH/PUT /api_accesss/1.json
  # def update
  #   respond_to do |format|
  #     if @api_access.update(api_access_params)
  #       if params[:api_access][:update_schedule].present?
  #         format.html { redirect_to schedule_api_access_path(:check => true), notice: 'ApiAccess updated' }
  #       elsif params[:api_access][:scheduled].present?
  #         format.html { redirect_to success_schedule_api_access_path, notice: 'Your api_access has been scheduled' }
  #       else
  #         format.html { redirect_to @api_access, notice: 'api_access was successfully updated.' }
  #         format.json { render :show, status: :ok, location: @api_access }
  #       end
  #     else
  #       @design = Design.find(@api_access.design_id)
  #       format.html { render :schedule, alert: 'Please try again...' }
  #       format.json { render json: @api_access.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /api_accesss/1
  # # DELETE /api_accesss/1.json
  # def destroy
  #   @api_access.destroy
  #   respond_to do |format|
  #     format.html { redirect_to api_accesss_url, notice: 'api_access was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  #
  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_api_access
    #   @api_access = ApiAccess.find(params[:id])
    #   redirect_to root_path if @api_access.user_id != current_user.id
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_access_params
      params.require(:api_access).permit(:name, :website_url, :description, :user_id)
    end

end
