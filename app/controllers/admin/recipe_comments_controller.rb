class Admin::RecipeCommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :set_recipe_comment, only: [:destroy]
  
  def index
    @comments = RecipeComment.includes(:recipe, :user).order(created_at: :desc).page(params[:page])
  end
  
  def destroy
    recipe = @comment.recipe  # リダイレクト用にrecipeを保存
    @comment.destroy
    redirect_to admin_recipe_path(recipe), notice: "コメントを削除しました。"
  end

  private

  def set_recipe_comment
    @comment = RecipeComment.find(params[:id])
  end
end