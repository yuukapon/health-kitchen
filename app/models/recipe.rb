class Recipe < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :recipe_comments, dependent: :destroy
  has_many :recipe_favorites, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipe_steps, dependent: :destroy
  
  # ジャンルのアソシエーション
  has_many :recipe_genres, dependent: :destroy  # 中間テーブルとの関連付け
  has_many :genres, through: :recipe_genres     # genresとの多対多の関連付け
  
  # ActiveStorage
  has_one_attached :image
  
  # ネストされた属性
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true
  accepts_nested_attributes_for :recipe_steps, allow_destroy: true
  accepts_nested_attributes_for :recipe_genres, allow_destroy: true
  
  # enum
  enum cook_time: {
    "5分以内": 0, 
    "約10分": 1,
    "約15分": 2,
    "約30分": 3,
    "約1時間": 4,
    "約2時間": 5,
    "約2時間以上": 6
  }
  
  # ransackで検索可能な属性を指定
  def self.ransackable_attributes(auth_object = nil)
    [
      "title",
      "description",
      "created_at",
      "people_count",
      "cook_time",
      "is_active"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    [
      "user",
      "recipe_ingredients",
      "genres",
      "recipe_favorites"
    ]
  end
  
  # バリデーション
  validates :title, presence: true, 
                   length: { minimum: 2, maximum: 20, 
                            message: "は2文字以上20文字以内で入力してください" }
  validates :description, length: { maximum: 250 }, 
                         allow_blank: true
  validates :cook_time, presence: true
  validates :people_count, presence: true
  validates :image, presence: true
  validates :recipe_genres, presence: true
      
  # インスタンスメソッド
  def favorited_by?(user)
    recipe_favorites.exists?(user_id: user.id)
  end
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      image.attach(io: File.open(file_path), 
                  filename: 'default-image.jpg', 
                  content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end