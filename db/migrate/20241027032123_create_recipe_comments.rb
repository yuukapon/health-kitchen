class CreateRecipeComments < ActiveRecord::Migration[6.1]
  def change
      create_table :recipe_comments do |t|
      t.text :comment, null: false    
      t.integer :user_id, null: false    
      t.integer :recipe_id, null: false    

      t.timestamps
    end
  end
end
