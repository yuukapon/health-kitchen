
class Public::RecipeCommentsController < ApplicationController
  before_action :authenticate_user! # ログインユーザーのみ許可
  
  def create
    recipe = Recipe.find(params[:recipe_id])
    recipe_comment = current_user.recipe_comments.new(recipe_comment_params)
    recipe_comment.recipe = recipe
  
    if recipe_comment.save
      redirect_to recipe_path(recipe), notice: "コメントを投稿しました。"
    else
      # @recipe = recipe
      # @recipe_comment = recipe_comment
      # @recipe_review = RecipeReview.new
      # render 'public/recipes/show', alert: "コメントの投稿に失敗しました。"
      redirect_to recipe_path(recipe), alert: "コメントの投稿に失敗しました。"
    end
  end

  
  def destroy
    recipe_comment = RecipeComment.find(params[:id])
    if recipe_comment.user == current_user
      recipe_comment.destroy
      redirect_to recipe_path(recipe_comment.recipe), notice: "コメントを削除しました。"
    else
      redirect_to recipe_path(recipe_comment.recipe), alert: "コメントの削除に失敗しました。"
    end
  end
  
  private
  
  def recipe_comment_params
    params.require(:recipe_comment).permit(:comment)
  end
end