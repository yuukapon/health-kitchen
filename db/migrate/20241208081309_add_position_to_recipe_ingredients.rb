class AddPositionToRecipeIngredients < ActiveRecord::Migration[6.1]
  def change
    add_column :recipe_ingredients, :position, :integer
    add_index :recipe_ingredients, :position
  end
end
