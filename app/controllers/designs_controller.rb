class DesignsController < ApplicationController

  def show
    @design = Design.find(params[:id])
  end
end
