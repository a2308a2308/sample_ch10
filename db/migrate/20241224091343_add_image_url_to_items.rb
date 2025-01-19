class AddImageUrlToItems < ActiveRecord::Migration[7.0]
  def change
    table_name = ENV['SCHEMA_NAME'].present? ? "#{ENV['SCHEMA_NAME']}.items" : 'items'
    add_column table_name, :image_url, :string
  end
end
