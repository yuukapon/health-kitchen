class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # ページネーション設定         
  paginates_per 10  # 1ページあたり10件表示

  # レシピ関連のアソシエーション
  has_many :recipes, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  has_many :recipe_favorites, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipe_steps, dependent: :destroy
  has_many :recipe_reviews, dependent: :destroy

  # ネストされた属性
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true
  accepts_nested_attributes_for :recipe_steps, allow_destroy: true

  # Active Storage
  has_one_attached :profile_image

  # バリデーション
  validates :name, presence: true, 
                  length: { minimum: 2, maximum: 15, 
                           message: "は2文字以上15文字以内で入力してください" }
  validates :introduction, 
            length: { maximum: 250,
                     message: "は250文字以内で入力してください" },
            allow_blank: true  

  # プロフィール画像取得
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/vegetable.png')
      profile_image.attach(io: File.open(file_path), 
                          filename: 'default-image.jpg', 
                          content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  # 検索用
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
  

  # 認証関連のメソッド
  def active_for_authentication?
    super && is_active  
  end

  def inactive_message
    is_active ? super : :deleted_account  
  end
end