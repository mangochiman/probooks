class UserBook < ActiveRecord::Base
  set_table_name :user_books
  set_primary_key :user_book_id

  belongs_to :user, :foreign_key => :user_id
  belongs_to :book, :foreign_key => :book_id
end
