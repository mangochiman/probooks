class StudentPoster < ActiveRecord::Base
  set_table_name :student_posters
  set_primary_key :student_poster_id

  belongs_to :poster, :foreign_key => :poster_id
end
