class Admin::DashboardsController < ApplicationController
    layout 'admin'
    before_action :authenticate_admin!
    
    def index
        @users = User.all.page(params[:page])
    end
    
    
    
end
