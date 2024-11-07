class RecipeStep < ApplicationRecord
  belongs_to :recipe
  has_one_attached :step_image
  
  validates :description, presence: true
  
  def get_image(width, height)
    unless step_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      step_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    step_image.variant(resize_to_limit: [width, height]).processed
  end
end