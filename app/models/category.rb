class Category < ActiveRecord::Base
  set_table_name :categories
  set_primary_key :category_id

  has_many :book_categories
end
