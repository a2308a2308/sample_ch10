class Scores < ActiveRecord::Migration[7.0]
  def change
    create_table :scores do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false
      t.integer :total, default: 0

      t.timestamps
    end
      add_index :scores, [:user_id, :date], unique: true # ユニークインデックスを追加
  end
end
