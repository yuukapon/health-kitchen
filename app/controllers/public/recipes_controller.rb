class Public::RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authorize_recipe, only: [:edit, :update, :destroy]

  def new
    @recipe = Recipe.new
    3.times { @recipe.recipe_ingredients.build }
    2.times { @recipe.recipe_steps.build }
    @recipe.recipe_genres.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    
    if @recipe.save
      flash[:success] = "レシピを投稿しました。"
      redirect_to recipe_path(@recipe)
    else
      # エラー時にフォームに必要な関連オブジェクトを再構築
      @recipe.recipe_ingredients.build if @recipe.recipe_ingredients.empty?
      @recipe.recipe_steps.build if @recipe.recipe_steps.empty?
      @recipe.recipe_genres.build if @recipe.recipe_genres.empty?
      
      flash.now[:error] = "入力内容に誤りがあります。"
      render :new
    end
  end
  
  def index
    @recipe = Recipe.new
    @q = Recipe.ransack(params[:q])
    @recipes = @q.result(distinct: true)
      .includes(:user, :recipe_ingredients, :genres, :recipe_favorites)
      .order(created_at: :desc)
      .page(params[:page])
  end

  def show
    @recipe_comment = RecipeComment.new
    @recipe_review = RecipeReview.new
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = "レシピを更新しました。"
      redirect_to recipe_path(@recipe)
    else
      flash.now[:error] = "レシピの更新に失敗しました。"
      render :edit
    end
  end


  def destroy
    @recipe.destroy
    flash[:success] = "レシピを削除しました。"
    redirect_to recipes_path
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "レシピが見つかりませんでした。"
    redirect_to recipes_path
  end

  def authorize_recipe
    unless @recipe.user == current_user
      flash[:error] = "このアクションは許可されていません。"
      redirect_to recipes_path
    end
  end

  def recipe_params
    params.require(:recipe).permit(
      :title,
      :description,
      :people_count,
      :cook_time,
      :is_active,
      :image,
      recipe_ingredients_attributes: [:id, :ingredient, :quantity, :_destroy],
      recipe_steps_attributes: [:id, :description, :step_image, :_destroy],
      recipe_genres_attributes: [:id, :genre_id, :_destroy] 
    )
  end
end