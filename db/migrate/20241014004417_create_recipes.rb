class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.references :user, null: false, foreign_key: true # '投稿ユーザー'
      t.string :title, null: false, limit: 20 # 'レシピタイトル'    
      t.text :description, limit: 250 #'レシピの説明'            
      t.string :people_count, null: false #'調理人数'
      t.integer :cook_time, null: false, default: 0 #'調理時間'
      t.boolean :is_active, null: false, default: true #'公開状態'
      t.timestamps
    end
  end
end