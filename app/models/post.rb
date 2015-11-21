class Post < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true
  validates :sub, :author_id, presence: true

  belongs_to :sub
  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: 'User'

  has_one :moderator,
    through: :sub,
    source: :moderator

  has_many :post_subs,
    dependent: :destroy,
    inverse_of: :post


  has_many :post_sub_subs,
    through: :post_subs,
    source: :sub


end
