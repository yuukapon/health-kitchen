class Admin::RecipeCommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def destroy
    comment = RecipeComment.find(params[:id])
    recipe = comment.recipe  # リダイレクト用にrecipeを保存
    comment.destroy
    redirect_to admin_recipe_path(recipe), notice: "コメントを削除しました。"
  end
end