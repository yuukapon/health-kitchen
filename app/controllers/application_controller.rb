# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :configure_authentication
 
  private
 
  def configure_authentication
    if admin_controller?
      authenticate_admin!
    else
      authenticate_user! unless action_is_public?
    end
  end
 
  def admin_controller?
    # Admin名前空間のコントローラを判定
    self.class.to_s.start_with?('Admin::')
  end
 
  def action_is_public?
    controller_name == 'recipes' && action_name == 'index'
    controller_name == 'homes' && ['top', 'about'].include?(action_name) # homes#topとhomes#aboutを許可
  end
end