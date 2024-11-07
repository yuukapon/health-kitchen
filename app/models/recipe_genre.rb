class RecipeGenre < ApplicationRecord
  belongs_to :recipe
  belongs_to :genre
  
  validates :genre_id, presence: true

end
