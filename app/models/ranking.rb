class Ranking < ApplicationRecord
    # ランキングデータを取得するメソッド
    def self.top_ranking(limit = 10)
      User.joins(:scores)
          .where(deleted_at: nil) # 削除されていないユーザーを対象
          .select('users.name AS user_name, SUM(scores.total) AS total_score') # totalを使う
          .group('users.id, users.name')
          .order('total_score DESC')
          .limit(limit) # トップ N のランキング
    end
  end
  