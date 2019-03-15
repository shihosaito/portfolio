class Album < ApplicationRecord

  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password

  def Album.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
