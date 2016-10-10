class Faculty < ActiveRecord::Base
  set_table_name :faculties
  set_primary_key :faculty_id

  has_many :book_faculties
end
