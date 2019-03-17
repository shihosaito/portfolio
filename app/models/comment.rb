class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :album

  validates :comment_text, length: { maximum: 200 }
  validates :user_id, presence: true
  validates :album_id, presence: true

end
