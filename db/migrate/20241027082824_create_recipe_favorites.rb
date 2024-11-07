class CreateRecipeFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_favorites do |t|
      t.integer :user_id, null: false    
      t.integer :recipe_id, null: false    

      t.timestamps
    end
  end
end
