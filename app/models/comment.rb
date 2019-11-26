class Comment < ApplicationRecord
  belongs_to :board
  has_many :replies, dependent: :destroy
end
