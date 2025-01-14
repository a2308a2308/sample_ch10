# メインのサンプルユーザーを1人作成する
#User.create!(name: 'Example User',
#             email: 'example@railstutorial.org',
#             password: 'foobar',
#             password_confirmation: 'foobar',
#             admin: true)

# 追加のユーザーをまとめて生成する
#99.times do |n|
#  name  = Faker::Name.name
#  email = "example-#{n + 1}@railstutorial.org"
#  password = 'password'
#  User.create!(name: name,
#               email: email,
#               password: password,
#               password_confirmation: password)
#end

# 環境変数でスキーマ名を取得（デフォルトは public）
schema_name = ENV.fetch('SCHEMA_NAME', 'public')

# スキーマを設定（PostgreSQLの場合のみ）
if ActiveRecord::Base.connection.adapter_name.downcase.include?("postgresql")
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
