class CreateRecipeReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_reviews do |t|
      t.float :healthy_rate, null: false # 健康度
      t.float :satisfaction_rate, null: false # 満足度
      t.float :easy_rate, null: false # 簡単さ
      t.text :comment
      t.references :recipe, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end