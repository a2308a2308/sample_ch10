class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :subject, null: false
      t.integer :question_type, null: false, default: 1
      t.string :question, null: false
      t.integer :level, null: false, default: 1
      t.integer :category_id, null: true
      t.timestamps
    end

    add_foreign_key :questions, :categories
    add_index :questions, :category_id
  end
end
