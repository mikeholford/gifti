class DesignsController < ApplicationController

  def index
    @designs = Design.all
  end

end
