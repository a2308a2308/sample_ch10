class QuestionsController < ApplicationController
  before_action :set_all_questions, only: [:start]
  before_action :set_current_question, only: [:show, :answer]

  def start
    # 全ての質問を取得
    @questions = Question.all.order(:id) # ID順に全質問を取得
    Rails.logger.debug "START action called: Questions retrieved: #{@questions.inspect}"


    if @questions.empty?
      flash[:alert] = "質問がありません。"
      redirect_to root_path
    else
      session[:question_ids] = @questions.pluck(:id) # 質問IDをセッションに保存
      session[:current_index] = 0 # 最初の質問のインデックスを初期化
      redirect_to question_path(@questions.first)
    end
  end

  def show
    # 現在の質問を表示
  end

  def answer
    selected_choice = params[:choice].to_i
    Rails.logger.debug "Answer submitted: #{selected_choice}"
    Rails.logger.debug "Current index before update: #{session[:current_index]}"

    if @current_question.correct_item_id == selected_choice
      current_user.increment_score
      flash[:notice] = "正解です！"
    else
      flash[:alert] = "不正解です。"
    end

    # 次の質問がある場合はインデックスを更新
    next_q = next_question
    if next_q
      session[:current_index] += 1
      redirect_to question_path(next_q)
    else
      flash[:notice] = "これが最後の質問です！お疲れ様でした！"
      Rails.logger.debug "Redirecting to summary_path: #{summary_path}"
      redirect_to summary_path
    end
  end

  def summary
    Rails.logger.debug "Summary"
    @score = current_user.score_for_date # 本日の得点を表示
    # セッションのリセット
    session[:current_index] = nil
  end

  private

  def set_all_questions
    Rails.logger.debug "Set All"
    # 全質問を取得してセット
    @questions = Question.all
  end

  def set_current_question
    Rails.logger.debug "Set current"
    question_ids = session[:question_ids] || []
    current_index = session[:current_index] || 0
    @current_question = Question.find(question_ids[current_index]) if question_ids.any?
  end

  def next_question
    question_ids = session[:question_ids] || []
    next_index = session[:current_index] + 1

    Rails.logger.debug "Session Question IDs: #{question_ids.inspect}"
    Rails.logger.debug "Current Index: #{session[:current_index]}"
    Rails.logger.debug "Next Index: #{next_index}"

    if next_index < question_ids.size
      next_question = Question.find_by(id: question_ids[next_index])
      Rails.logger.debug "Next Question: #{next_question.inspect}"
      # session[:current_index] = next_index
      return next_question
    else
      Rails.logger.debug "No more questions available."
      return nil
    end
  end
end
