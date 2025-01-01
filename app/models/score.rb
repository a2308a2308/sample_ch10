class Score < ApplicationRecord
  belongs_to :user
  validates :date, presence: true
  validates :total, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end