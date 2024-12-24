class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    @items = @question.items # 正しく関連付けされたItemを取得
  end
end
