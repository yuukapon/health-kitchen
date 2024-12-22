class Admin::RecipeCommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :set_recipe_comment, only: [:destroy]
  
  def index
    @comments = RecipeComment.includes(:recipe, :user).order(created_at: :desc).page(params[:page])
    # order 並べ替え
    # reated_at `ソートの基準
    # :desc`降順（大きいものから小さいものの順）
  end
  
  def show
  end
  
  def destroy
    recipe = @comment.recipe  # リダイレクト用にrecipeを保存
    @comment.destroy
    redirect_to admin_recipe_comments_path, notice: "コメントを削除しました。"
  end

  private

  def set_recipe_comment
    @comment = RecipeComment.find(params[:id])
  end
end