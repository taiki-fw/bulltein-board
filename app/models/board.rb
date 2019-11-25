class Board < ApplicationRecord
  # dependent: :destroy とすることで、boardを削除した時、整合性を保つために関連したcommentも同時に削除する
  has_many :comments, dependent: :destroy
end
