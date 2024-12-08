# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :configure_authentication
  
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      new_user_registration_path  # ユーザーの場合は新規登録画面へ
    end
  end
 
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