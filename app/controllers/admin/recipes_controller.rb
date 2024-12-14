class Admin::RecipesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :set_recipe, only: [:show, :destroy] 
  
  def index
    @q = Recipe.ransack(params[:q])
    @recipes = @q.result(distinct: true)
      .includes(:user, :recipe_ingredients, :genres, :recipe_favorites)
      .order(created_at: :desc)
      .page(params[:page])
  end
  

  def show
    # set_recipeで@recipeが設定されるので、ここは空でOK
    @recipe_comments = @recipe.recipe_comments  # コメント一覧を表示
  end
  
  def destroy
    @recipe.destroy
    flash[:notice] = "レシピを削除しました。"
    redirect_to admin_recipes_path  # 管理者用のパスに修正
  end
  
  private
  def set_recipe
    @recipe = Recipe.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "レシピが見つかりませんでした。"
    redirect_to admin_recipes_path
  end
end