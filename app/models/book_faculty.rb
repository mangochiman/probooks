require "composite_primary_keys"
class BookFaculty < ActiveRecord::Base
  set_table_name :book_faculties
  set_primary_keys :book_id, :faculty_id

  belongs_to :book
  belongs_to :faculty

  before_save :add_time_stamps

  def add_time_stamps
    self.created_at = Time.now if self.created_at.blank?
    self.updated_at = Time.now
  end
  
end
