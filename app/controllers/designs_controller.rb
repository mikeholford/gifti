class DesignsController < ApplicationController

  before_action :authenticate_user!

  def index
    @designs = Design.all
  end

end
