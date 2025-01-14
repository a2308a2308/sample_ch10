class CreateItems < ActiveRecord::Migration[7.0]
  def change
  table_name = ENV['SCHEMA_NAME'].present? ? "#{ENV['SCHEMA_NAME']}.items" : 'items'
    unless table_exists?(table_name)
      create_table table_name do |t|
        t.references :question, null: false, foreign_key: true # question_id の外部キー
        t.string :answer, null: false                         # 回答内容
        t.boolean :correct, null: false, default: false       # 正解かどうか
        t.timestamps                                          # 作成日時、更新日時
      end
    end
  end
end