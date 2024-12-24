require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @category = Category.create!(name: '英単語')
    @question = Question.create!(subject: 'Sample Question', question_type: 1, question: 'Apple', level: 1,
                                 category_id: @category.id)
    @item = Item.new(question_id: @question.id, answer: 'リンゴ', correct: true)
    @item = Item.new(question_id: @question.id, answer: 'ブドウ', correct: false)
    @item = Item.new(question_id: @question.id, answer: 'バナナ', correct: false)
    @item = Item.new(question_id: @question.id, answer: 'みかん', correct: false)
  end

  test 'valid item' do
    assert @item.valid?
  end

  test 'invalid without question_id' do
    @item.question_id = nil
    assert_not @item.valid?, 'Item is valid without a question_id'
  end

  test 'invalid without answer' do
    @item.answer = nil
    assert_not @item.valid?, 'Item is valid without an answer'
  end

  test 'invalid without correct flag' do
    @item.correct = nil
    assert_not @item.valid?, 'Item is valid without a correct flag'
  end
end
