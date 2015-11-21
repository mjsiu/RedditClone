class Sub < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true
  validates :moderator_id, presence: true

  has_many :posts,
    dependent: :destroy

  has_many :post_subs,
    dependent: :destroy,
    inverse_of: :sub

  has_many :post_sub_posts,
    through: :post_subs,
    source: :post

  belongs_to :moderator,
  foreign_key: :moderator_id,
  primary_key: :id,
  class_name: 'User'

end
