class Post < ActiveRecord::Base

  validates :title, presence: true, uniqueness: true
  validates :sub_id, :author_id, presence: true


  belongs_to :sub
  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: 'User'

  has_one :moderator,
    through: :sub,
    source: :moderator



end
