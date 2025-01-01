require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create!(name: '英単語')
    @question = Question.create!(subject: 'Sample Question', question_type: 1, question: 'Apple', level: 1,
                                 category_id: @category.id)

    # Itemsをデータベースに保存
    @item1 = Item.create!(question_id: @question.id, answer: 'リンゴ', correct: true)
    @item2 = Item.create!(question_id: @question.id, answer: 'ブドウ', correct: false)
    @item3 = Item.create!(question_id: @question.id, answer: 'バナナ', correct: false)
    @item4 = Item.create!(question_id: @question.id, answer: 'みかん', correct: false)
  end

  test 'should get index' do
    get question_items_url(@question)
    assert_response :success
  end

  test 'should create item' do
    assert_difference('Item.count', 1) do
      post question_items_url(@question), params: { item: { answer: 'New Answer', correct: false } }
    end
    assert_response :redirect
  end

  test 'should not create item with invalid data' do
    assert_no_difference('Item.count') do
      post question_items_url(@question), params: { item: { answer: '', correct: nil } }
    end
    assert_response :unprocessable_entity
  end
end
