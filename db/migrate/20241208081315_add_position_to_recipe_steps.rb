class AddPositionToRecipeSteps < ActiveRecord::Migration[6.1]
  def change
    add_column :recipe_steps, :position, :integer
    add_index :recipe_steps, :position
  end
end
