class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  
  private
  def self.admin_access_only(*args)
    before_filter :ensure_admin_access_only, *args
  end
  
  def ensure_admin_access_only
    unless current_user.try(:admin?)
      flash[:alert] = "Access denied"
      redirect_to root_path
    end
  end
end
