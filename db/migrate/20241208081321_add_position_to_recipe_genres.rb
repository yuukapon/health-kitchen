class AddPositionToRecipeGenres < ActiveRecord::Migration[6.1]
  def change
    add_column :recipe_genres, :position, :integer
    add_index :recipe_genres, :position
  end
end
