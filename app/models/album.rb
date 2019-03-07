class Album < ApplicationRecord

  belongs_to :user
  has_many :photos
  has_many :rooms

end
