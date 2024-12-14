class ApplicationController < ActionController::Base
  before_action :configure_authentication
  helper_method :admin_signed_in? 
  
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      new_user_registration_path
    end
  end
 
  private
 
  def configure_authentication
    if admin_controller? && !admin_sessions_controller?  
      authenticate_admin!
    else
      authenticate_user! unless action_is_public?
    end
  end
 
  def admin_controller?
    self.class.to_s.start_with?('Admin::')
  end
  
  def admin_sessions_controller?
    self.class.to_s == 'Admin::SessionsController'
  end
 
  def action_is_public?
    (controller_name == 'recipes' && action_name == 'index') ||
    (controller_name == 'homes' && ['top', 'about'].include?(action_name))
  end
  
  def authenticate_admin!
    unless admin_signed_in?
      flash[:alert] = "管理者権限が必要です"
      redirect_to new_admin_session_path
    end
  end
  
  def admin_signed_in?
    current_admin.present?
  end
end