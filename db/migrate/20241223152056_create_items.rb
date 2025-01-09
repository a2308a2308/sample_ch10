class CreateItems < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:items)
      create_table :items do |t|
        t.references :question, null: false, foreign_key: true # question_id の外部キー
        t.string :answer, null: false                         # 回答内容
        t.boolean :correct, null: false, default: false       # 正解かどうか
        t.timestamps                                          # 作成日時、更新日時
    end
  end
end