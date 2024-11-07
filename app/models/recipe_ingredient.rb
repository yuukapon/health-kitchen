class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  
  validates :ingredient, presence: true
  validates :quantity, presence: true
  
    # ransackで検索可能な属性を指定
  def self.ransackable_attributes(auth_object = nil)
    ["ingredient", "quantity"]  # 検索に必要な属性のみを許可
  end

  # 関連モデルでの検索を許可
  def self.ransackable_associations(auth_object = nil)
    ["recipe"]
  end
  
end
