# app/models/score.rb
class Score < ApplicationRecord
    belongs_to :user
  
    validates :user_id, presence: true
    validates :act_date, presence: true
    validates :point, presence: true
  end
  