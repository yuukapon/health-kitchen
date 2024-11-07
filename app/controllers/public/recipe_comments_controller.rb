class Public::RecipeCommentsController < ApplicationController
  before_action :authenticate_user! # ログインユーザーのみ許可
  
  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = current_user.recipe_comments.new(recipe_comment_params)
    comment.recipe_id = recipe.id
    
  
    if comment.save
      redirect_to recipe_path(recipe), notice: "コメントを投稿しました。"
    else
      redirect_to recipe_path(recipe), alert: "コメントの投稿に失敗しました。"
    end
  end
  
  def destroy
    comment = RecipeComment.find(params[:id])
    if comment.user == current_user
      comment.destroy
      redirect_to recipe_path(comment.recipe), notice: "コメントを削除しました。"
    else
      redirect_to recipe_path(comment.recipe), alert: "コメントの削除に失敗しました。"
    end
  end
  
  private
  
  def recipe_comment_params
    params.require(:recipe_comment).permit(:comment)
  end
end