class PostSub < ActiveRecord::Base
  belongs_to :sub
  belongs_to :post

  validates :sub, :post, presence: true

end
