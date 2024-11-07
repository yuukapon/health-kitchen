class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:update]
  
  def index
    @users = User.order(created_at: :desc).page(params[:page])
  end
  
  def update
    if @user.update(is_active: false)
      flash[:notice] = "#{@user.name}さんを退会させました。"
    else
      flash[:alert] = "退会処理に失敗しました。"
    end
    redirect_to admin_dashboards_path
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "ユーザーが見つかりません。"
    redirect_to admin_dashboards_path
  end
end