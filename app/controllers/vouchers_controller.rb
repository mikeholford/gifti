class VouchersController < ApplicationController
  before_action :set_voucher, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :destroy]

  layout 'headless', :only => [ :capture ]

  def index
    redirect_to new_voucher_path
  end


  def show
    @voucher = Voucher.find(params[:id])
  end

  def capture
    if params[:key].present?
      @user = User.find_by_secret_key(params[:key])
      if @user.present?
        @voucher = Voucher.find(params[:id])
      else
        redirect_to '/'
      end
    else
      redirect_to '/'
    end
  end

  def schedule
    @voucher = Voucher.find(params[:id])
  end

  def success_schedule
    @voucher = Voucher.find(params[:id])
    redirect_to schedule_voucher_path if @voucher.scheduled == false
  end


  def new
    if params[:design].present?
      @design = Design.where(template: params[:design]).last
      if @design.present?
        @voucher = Voucher.new
      else
        redirect_to designs_path
      end
    else
      redirect_to designs_path
    end
  end


  def edit
  end


  def create
    @voucher = Voucher.new(voucher_params.merge(:user_id => current_user.id))
    respond_to do |format|
      if @voucher.save
        format.html { redirect_to @voucher, notice: 'Your voucher has been created!' }
        format.json { render :show, status: :created, location: @voucher }
      else
        @design = Design.find(@voucher.design_id)
        format.html { render :new, alert: 'Please try again...' }
        format.json { render json: @voucher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vouchers/1
  # PATCH/PUT /vouchers/1.json
  def update
    respond_to do |format|
      if @voucher.update(voucher_params)
        if params[:voucher][:update_schedule].present?
          format.html { redirect_to schedule_voucher_path(:check => true), notice: 'Voucher updated' }
        elsif params[:voucher][:scheduled].present?
          format.html { redirect_to success_schedule_voucher_path, notice: 'Your voucher has been scheduled' }
        else
          format.html { redirect_to @voucher, notice: 'voucher was successfully updated.' }
          format.json { render :show, status: :ok, location: @voucher }
        end
      else
        @design = Design.find(@voucher.design_id)
        format.html { render :schedule, alert: 'Please try again...' }
        format.json { render json: @voucher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vouchers/1
  # DELETE /vouchers/1.json
  def destroy
    @voucher.destroy
    respond_to do |format|
      format.html { redirect_to vouchers_url, notice: 'voucher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_voucher
      @voucher = Voucher.find(params[:id])
      redirect_to root_path if @voucher.user_id != current_user.id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def voucher_params
      params.require(:voucher).permit(:name, :heading, :sub_heading, :value, :from, :for, :code, :send_at, :message, :design_id, :user_id, :valid_until, :discount_type, :service, :for_email, :scheduled)
    end

end
