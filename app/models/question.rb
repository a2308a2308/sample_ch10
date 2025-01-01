class Question < ApplicationRecord
  belongs_to :category
  has_many :items, dependent: :destroy # Itemとの関連付けを追加
  def correct_item_id
    items.find_by(correct: true)&.id
  end
end
