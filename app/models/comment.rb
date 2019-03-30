class Comment < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :admin, optional: true
  belongs_to :album

  acts_as_paranoid

  validates :comment_text, length: { maximum: 200 }
  validates :user_id, presence: true
  validates :album_id, presence: true

end
