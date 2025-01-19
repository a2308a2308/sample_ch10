class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    table_name = ENV['SCHEMA_NAME'].present? ? "#{ENV['SCHEMA_NAME']}.users" : 'users'
    create_table table_name do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
