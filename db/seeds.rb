# メインのサンプルユーザーを1人作成する
# User.create!(name: 'Example User',
#             email: 'example@railstutorial.org',
#             password: 'foobar',
#             password_confirmation: 'foobar',
#             admin: true)

# 追加のユーザーをまとめて生成する
# 99.times do |n|
#  name  = Faker::Name.name
#  email = "example-#{n + 1}@railstutorial.org"
#  password = 'password'
#  User.create!(name: name,
#               email: email,
#               password: password,
#               password_confirmation: password)
# end

# 環境変数でスキーマ名を取得（デフォルトは public）
schema_name = ENV.fetch('SCHEMA_NAME', 'public')

# スキーマを設定（PostgreSQLの場合のみ）
if ActiveRecord::Base.connection.adapter_name.downcase.include?('postgresql')
  ActiveRecord::Base.connection.execute("SET search_path TO #{schema_name}")
end

# サンプル質問を作成
question = Question.find_or_create_by(
  subject: 'サンプル質問',
  question_type: 1,
  question: 'Apple',
  level: 1,
  category: Category.find_or_create_by(name: '英単語')
)

# アイテムデータと画像パス
items_with_images = [
  { answer: 'リンゴ', correct: true, image_path: 'public/sample_images/apple.jpeg' },
  { answer: 'バナナ', correct: false, image_path: 'public/sample_images/banana.jpeg' },
  { answer: 'オレンジ', correct: false, image_path: 'public/sample_images/orange.jpeg' },
  { answer: 'ブドウ', correct: false, image_path: 'public/sample_images/grape.jpeg' }
]

# アイテムを作成し、画像をアタッチ
items_with_images.each do |data|
  item = Item.find_or_create_by(
    question: question,
    answer: data[:answer],
    correct: data[:correct]
  )

  next if item.image.attached? # 既にアタッチされている場合はスキップ

  file_path = Rails.root.join(data[:image_path])
  item.image.attach(io: File.open(file_path), filename: File.basename(file_path), content_type: 'image/jpeg')
end

# サンプル質問２を作成
question = Question.find_or_create_by(
  subject: 'サンプル質問',
  question_type: 1,
  question: 'lion',
  level: 1,
  category: Category.find_or_create_by(name: '英単語')
)

# アイテムデータと画像パス
items_with_images = [
  { answer: 'ゾウ', correct: false, image_path: 'public/sample_images/elephant.jpeg' },
  { answer: 'キリン', correct: false, image_path: 'public/sample_images/giraffe.jpeg' },
  { answer: 'ライオン', correct: true, image_path: 'public/sample_images/lion.jpeg' },
  { answer: 'シマウマ', correct: false, image_path: 'public/sample_images/zebra.jpeg' }
]

# アイテムを作成し、画像をアタッチ
items_with_images.each do |data|
  item = Item.find_or_create_by(
    question: question,
    answer: data[:answer],
    correct: data[:correct]
  )

  next if item.image.attached? # 既にアタッチされている場合はスキップ

  file_path = Rails.root.join(data[:image_path])
  item.image.attach(io: File.open(file_path), filename: File.basename(file_path), content_type: 'image/jpeg')
end

# ---------------------------------------------------------------------
# 問題追加
# ---------------------------------------------------------------------
# 問題
adding_questions = [
  { question: 'bus', level: 2 },
  { question: 'bee', level: 2 },
  { question: 'chameleon', level: 3 },
  { question: 'shovelcar', level: 3 }
]

# アイテムデータと画像パス
adding_items_with_images = [
  # bus の選択肢
  { question: 'bus', answer: '救急車', correct: false, image_path: 'public/sample_images/ambulance.jpeg' },
  { question: 'bus', answer: 'バイク', correct: false, image_path: 'public/sample_images/bike.jpeg' },
  { question: 'bus', answer: 'バス', correct: true, image_path: 'public/sample_images/bus.jpeg' },
  { question: 'bus', answer: '機関車', correct: false, image_path: 'public/sample_images/locomotive.jpeg' },

  # bee の選択肢
  { question: 'bee', answer: 'ちょう', correct: false, image_path: 'public/sample_images/butterfly.jpeg' },
  { question: 'bee', answer: 'かまきり', correct: false, image_path: 'public/sample_images/mantis.jpeg' },
  { question: 'bee', answer: 'はち', correct: true, image_path: 'public/sample_images/bee.jpeg' },
  { question: 'bee', answer: 'くも', correct: false, image_path: 'public/sample_images/spider.jpeg' },

  # chameleon の選択肢
  { question: 'chameleon', answer: 'カメレオン', correct: true, image_path: 'public/sample_images/chameleon.jpeg' },
  { question: 'chameleon', answer: 'カエル', correct: false, image_path: 'public/sample_images/frog.jpeg' },
  { question: 'chameleon', answer: 'ヘビ', correct: false, image_path: 'public/sample_images/snake.jpeg' },
  { question: 'chameleon', answer: 'カメ', correct: false, image_path: 'public/sample_images/turtle.jpeg' },

  # shovelcar の選択肢
  { question: 'shovelcar', answer: '消防車', correct: false, image_path: 'public/sample_images/fire_truck.jpeg' },
  { question: 'shovelcar', answer: 'ロードローラー', correct: false, image_path: 'public/sample_images/road_roller.jpeg' },
  { question: 'shovelcar', answer: 'ロケット', correct: false, image_path: 'public/sample_images/rocket.jpeg' },
  { question: 'shovelcar', answer: 'ショベルカー', correct: true, image_path: 'public/sample_images/shovelcar.jpeg' }
]

# 質問を追加
adding_questions.each do |q|
  question = Question.find_or_create_by(
    subject: 'サンプル質問',
    question_type: 2,
    question: q[:question],
    level: q[:level],
    category: Category.find_or_create_by(name: '英単語')
  )

  # 質問に紐づくアイテムを作成
  adding_items_with_images.select { |item| item[:question] == q[:question] }.each do |data|
    item = Item.find_or_create_by(
      question: question,
      answer: data[:answer],
      correct: data[:correct]
    )

    # 画像をアタッチ（既にアタッチ済みならスキップ）
    next if item.image.attached?

    file_path = Rails.root.join(data[:image_path])
    item.image.attach(io: File.open(file_path), filename: File.basename(file_path), content_type: 'image/jpeg')
  end
end