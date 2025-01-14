class Scores < ActiveRecord::Migration[7.0]
  def change
    table_name = ENV['SCHEMA_NAME'].present? ? "#{ENV['SCHEMA_NAME']}.scores" : 'scores'
    create_table table_name do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false
      t.integer :total, default: 0

      t.timestamps
    end
      add_index :scores, [:user_id, :date], unique: true # ユニークインデックスを追加
  end
end
