class VouchersController < ApplicationController
  before_action :set_voucher, only: [:show, :edit, :update, :destroy]


  def index
    @vouchers = Voucher.all
  end


  def show
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
    # Rails.application.credentials.screenshotlayer[:access_key]
  end


  def new
    @voucher = Voucher.new
  end


  def edit
  end


  def create
    @voucher = Voucher.new(voucher_params)

    respond_to do |format|
      if @voucher.save
        format.html { redirect_to @voucher, notice: 'voucher was successfully created.' }
        format.json { render :show, status: :created, location: @voucher }
      else
        format.html { render :new }
        format.json { render json: @voucher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vouchers/1
  # PATCH/PUT /vouchers/1.json
  def update
    respond_to do |format|
      if @voucher.update(voucher_params)
        format.html { redirect_to @voucher, notice: 'voucher was successfully updated.' }
        format.json { render :show, status: :ok, location: @voucher }
      else
        format.html { render :edit }
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def voucher_params
      params.require(:voucher).permit(:name, :heading, :sub_heading, :value, :from, :for, :code, :send_at, :message, :design_id, :user_id, :valid_until, :discount_type, :service)
    end

end
