class RecipeReview < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  
  # 同じユーザーが同じレシピに対して複数のレビューを投稿できないようにする
  validates :user_id, uniqueness: { 
    scope: :recipe_id,
    message: "は既にこのレシピをレビュー済みです" 
  }
  
  # 評価の存在チェックと数値範囲チェック
  validates :healthy_rate, :satisfaction_rate, :easy_rate,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 5
            }
  
  # 自分のレシピにレビューできないようにするカスタムバリデーション
  validate :cannot_review_own_recipe
  
  # 平均評価を計算するメソッド
  def average_rate
    ((healthy_rate + satisfaction_rate + easy_rate) / 3.0).round(1)
  end
  
  private
  
  def cannot_review_own_recipe
    if recipe.user_id == user_id
      errors.add(:base, "自分のレシピにはレビューできません")
    end
  end
end