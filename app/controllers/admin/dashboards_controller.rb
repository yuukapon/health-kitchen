class Admin::DashboardsController < ApplicationController
    layout 'admin'
    before_action :authenticate_admin!  # 管理者認証
    def index
        @users = User.all.page(params[:page])
    end
    
end
