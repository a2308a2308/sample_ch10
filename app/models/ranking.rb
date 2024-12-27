# C:\Users\hkata\my_project\sample_ch10\app\models\ranking.rb
class Ranking < ApplicationRecord
    # ランキング取得メソッド
    def self.get_rankings
      # ユーザーごとのスコアを合計して、得点順にソート
      User.joins(:scores)
          .group('users.id')
          .select('users.name AS username, SUM(scores.point) AS total_score')
          .order('total_score DESC')
    end
  end
  