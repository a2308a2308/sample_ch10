class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :answer]
  #before_action :authenticate_user!


  def show
    # クイズ表示用
  end

  def answer
    Rails.logger.debug "Params: #{params.inspect}" # パラメータの中身を確認

    selected_choice = params[:choice].to_i # ユーザーが選んだ選択肢
    Rails.logger.info "Answer submitted by user: #{current_user.id}, Date: #{Date.today}"
    Rails.logger.debug "Selected Choice ID: #{selected_choice}"
    Rails.logger.debug "Correct Item ID: #{@question.correct_item_id}"

    if @question.correct_item_id == selected_choice
      current_user.increment_score # `total` をカウントアップ
      flash[:notice] = "正解です！"
    else
      flash[:alert] = "不正解です。"
    end

    redirect_to question_path(@question) # クイズページにリダイレクト
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end
end