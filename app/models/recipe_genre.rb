class RecipeGenre < ApplicationRecord
  belongs_to :recipe
  belongs_to :genre
  acts_as_list scope: :recipe
  
  validates :genre_id, presence: true

end
