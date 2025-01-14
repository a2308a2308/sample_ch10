class RankingsController < ApplicationController
  def index
    @rankings = Ranking.top_ranking(10) # トップ10を取得
  end
end
