class UserNote < ActiveRecord::Base
  set_table_name :user_note
  set_primary_key :user_note_id

  belongs_to :user, :foreign_key => :user_id, :primary_key => :user_id
end
