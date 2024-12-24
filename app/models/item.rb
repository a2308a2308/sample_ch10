class Item < ApplicationRecord
  belongs_to :question
  validates :question_id, presence: true
  validates :answer, presence: true
  validates :correct, inclusion: { in: [true, false] } # booleanのバリデーション

end
