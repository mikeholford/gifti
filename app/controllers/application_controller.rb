class ApplicationController < ActionController::Base

  # Custom method to render 404
  def render_not_found
    render :file => "#{Rails.root}/public/404.html",  :status => 404
  end
end
