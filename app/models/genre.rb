class Genre < ApplicationRecord
  has_many :recipe_genres, dependent: :destroy
  has_many :recipes, through: :recipe_genres
  
  
  validates :name, presence: true, 
                uniqueness: { message: 'はすでに存在します' },
                length: { maximum: 10 }

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
  
end
