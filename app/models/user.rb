class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :album, dependent: :destroy
  has_many :photos, through: :albums
  has_many :comments

  def move_to(user)
    comments.update_all(user_id: user.id)
  end

end
