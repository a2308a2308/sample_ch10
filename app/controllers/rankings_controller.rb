class RankingsController < ApplicationController
    def index
      @rankings = Ranking.order(score: :desc)
    end
  end
  