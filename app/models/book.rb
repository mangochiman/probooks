class Book < ActiveRecord::Base
  set_table_name :books
  set_primary_key :book_id

  has_many :book_categories
end
