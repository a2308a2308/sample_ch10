class AddRememberDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    table_name = ENV['SCHEMA_NAME'].present? ? "#{ENV['SCHEMA_NAME']}.users" : 'users'
    add_column table_name, :remember_digest, :string
  end
end
