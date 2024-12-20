class Admin::RecipeReviewsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  before_action :set_recipe_review, only: [:destroy]
  
  def index
    @reviews = RecipeReview.includes(:recipe, :user).order(created_at: :desc).page(params[:page])
  end

  def destroy
    recipe = @review.recipe  # リダイレクト用にrecipeを保存
    @review.destroy
    redirect_to admin_recipe_path(recipe), notice: 'レビューを削除しました'
  end

  private

  def set_recipe_review
    @review = RecipeReview.find(params[:id])
  end
end