class DesignsController < ApplicationController

  before_action :authenticate_user!

  def index
    @designs = Design.order(:name).page(params[:page]).per(10)
  end

end
