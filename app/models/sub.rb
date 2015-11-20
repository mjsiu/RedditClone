class Sub < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true
  validates :moderator_id, presence: true

  has_many :posts,
    dependent: :destroy

  belongs_to :moderator,
  foreign_key: :moderator_id,
  primary_key: :id,
  class_name: 'User'

end
