class CreateRecipeGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_genres do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
    # 同じレシピ-ジャンルの組み合わせが重複しないようにインデックスを追加
    add_index :recipe_genres, [:recipe_id, :genre_id], unique: true
  end
end
