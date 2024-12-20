class Public::RecipeReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe
  before_action :set_recipe_review, only: [:edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
    
  def create
    @recipe_review = @recipe.recipe_reviews.build(recipe_review_params)
    @recipe_review.user = current_user
    
    if @recipe_review.save
      redirect_to recipe_path(@recipe), notice: 'レビューを投稿しました'
    else
      @recipe_comment = RecipeComment.new
      
      # エラーメッセージをカスタマイズ
      if @recipe_review.errors[:user_id].any?
        flash.now[:alert] = 'このレシピは既にレビュー済みです'
      else
        flash.now[:alert] = 'すべての評価を入力してください'
      end
      
      render 'public/recipes/show', status: :unprocessable_entity
    end
  end

  def edit
    # set_recipeとset_recipe_reviewで既に設定されているので不要
  end

  def update
    if @recipe_review.update(recipe_review_params)
      redirect_to recipe_path(@recipe), notice: 'レビューを更新しました'
    else
      # エラー時のレンダリングでフォームの値を保持
      render :edit
    end
  end

  def destroy
    @recipe_review.destroy
    redirect_to recipe_path(@recipe), notice: 'レビューを削除しました'
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
  
  def set_recipe_review
    @recipe_review = @recipe.recipe_reviews.find(params[:id])
  end
  
  def recipe_review_params
    params.require(:recipe_review).permit(:healthy_rate, :satisfaction_rate, :easy_rate, :comment)
  end
  
  def ensure_correct_user
    unless @recipe_review.user == current_user
      redirect_to recipe_path(@recipe), alert: '他のユーザーのレビューは編集できません'
    end
  end
end