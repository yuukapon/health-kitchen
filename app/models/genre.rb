class Genre < ApplicationRecord
  has_many :recipe_genres, dependent: :destroy
  has_many :recipes, through: :recipe_genres
  
  
  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
  
end
