require "composite_primary_keys"
class BookFaculty < ActiveRecord::Base
  set_table_name :book_faculties
  set_primary_keys :book_id, :faculty_id

  belongs_to :book
  belongs_to :faculty
end
