class AddIndexToUsersEmail < ActiveRecord::Migration[7.0]
  def change
    table_name = ENV['SCHEMA_NAME'].present? ? "#{ENV['SCHEMA_NAME']}.users" : 'users'
    add_index table_name, :email, unique: true
  end
end