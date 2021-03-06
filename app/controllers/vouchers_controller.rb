class VouchersController < ApplicationController

  before_action :set_voucher, only: [:show, :edit, :update, :destroy, :schedule, :success_schedule]
  before_action :authenticate_user!, except: [:capture]

  layout 'headless', :only => [ :capture ]

  def index
    redirect_to new_voucher_path
  end

  def show
  end

  def capture
    @user = User.find_by_secret_key(params[:key])
    if @user.present?
      @voucher = @user.vouchers.find(params[:id])
    else
      render_not_found
    end
  end

  def schedule
  end

  def success_schedule
    @voucher = Voucher.find(params[:id])
    redirect_to schedule_voucher_path, alert: 'Voucher not scheduled' unless @voucher.scheduled?
  end

  def new
    @voucher = Voucher.new
    @design = Design.find_by_template(params[:design])
    params[:blank].present? ? @sample = Voucher::BLANK : @sample = Voucher::FAKE.sample
    redirect_to designs_path, alert: 'Please select a design' unless @design.present?
  end

  def edit
  end

  def create
    @voucher = Voucher.new(voucher_params.merge(:user_id => current_user.id))
    if @voucher.save
      redirect_to @voucher, notice: 'Your voucher has been created!'
    else
      @design = Design.find(@voucher.design_id)
      @sample = params[:blank].present? ? Voucher::BLANK : Voucher::FAKE.sample
      flash[:alert] = 'Please try again...'
      render :new
    end
  end

  def update
    if @voucher.update(voucher_params)
      if params[:voucher][:update_schedule].present?
        redirect_to schedule_voucher_path(:check => true), notice: 'Voucher scheduled updated'
      elsif params[:voucher][:scheduled].present?
        redirect_to success_schedule_voucher_path, notice: 'Your voucher has been scheduled 🎉'
      else
        redirect_to @voucher, notice: 'Voucher successfully updated.'
      end
    else
      @design = Design.find(@voucher.design_id)
      flash[:alert] = 'Please try again...'
      render :schedule
    end
  end

  def destroy
    @voucher.destroy
    redirect_to vouchers_url, notice: 'Voucher successfully destroyed.'
  end

  private

    def set_voucher
      @voucher = current_user.vouchers.find(params[:id])
    end

    def voucher_params
      params.require(:voucher).permit(:name, :heading, :sub_heading, :value, :from, :for, :code, :send_at, :message, :design_id, :user_id, :valid_until, :discount_type, :service, :for_email, :scheduled)
    end

end
