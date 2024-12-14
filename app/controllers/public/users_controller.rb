class Public::UsersController < ApplicationController
  before_action :authenticate_user! # Deviseの認証確認を追加
  before_action :set_user, only: [:show, :edit, :update, :withdraw]
  before_action :ensure_correct_user, only: [:edit, :update, :withdraw]
  
  def index
  end
  
  def show
    @user = User.find(params[:id])
    @q = @user.recipes.ransack(params[:q])  
    @recipes = @q.result(distinct: true)     
                 .includes(:recipe_ingredients, :recipe_favorites)
                 .order(created_at: :desc)
                 .page(params[:page])
                    
                    
  end
  
  def edit
  end
    
  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def withdraw
    if @user.update(is_active: false)
      reset_session
      flash[:notice] = "退会処理が完了しました。ご利用ありがとうございました。"
      redirect_to new_user_registration_path
    else
      flash.now[:alert] = "退会処理に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "ユーザーが見つかりません。"
    redirect_to root_path, status: :not_found
  end
  
  def ensure_correct_user
    unless @user == current_user
      flash[:alert] = "権限がありません。"
      redirect_to user_path(current_user)
    end
  end
  
  def user_params
    params.require(:user)
          .permit(:name, :introduction, :profile_image, :is_active)
  end
end