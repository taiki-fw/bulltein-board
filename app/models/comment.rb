class Comment < ApplicationRecord
  belongs_to :board
  has_many :replys
end
