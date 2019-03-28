class Album < ApplicationRecord

  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy


  validates :album_name, presence: true
  validates :password_digest, presence: true
  validates :user_id, presence: true

  validates :album_name, length: { maximum: 20 }
  validates :password_digest, length: { minimum: 6 }

  has_secure_password

  def Album.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
