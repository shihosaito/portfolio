class Room < ApplicationRecord

  has_many :comments
  belongs_to :user
  belongs_to :albums

end
