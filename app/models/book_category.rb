require "composite_primary_keys"
class BookCategory < ActiveRecord::Base
  set_table_name :book_categories
  set_primary_keys :book_id, :category_id

  belongs_to :book
  belongs_to :category
  
end
