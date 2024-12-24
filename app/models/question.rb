class Question < ApplicationRecord
  belongs_to :category
  has_many :items, dependent: :destroy # Itemとの関連付けを追加
end
