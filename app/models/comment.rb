class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :flower

  validates :body, presence: true
end
