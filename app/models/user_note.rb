class UserNote < ActiveRecord::Base
  set_table_name :user_notes
  set_primary_key :user_note_id

  belongs_to :user, :foreign_key => :user_id, :primary_key => :user_id
  validates_presence_of :data, :message => "_Notes can't be blank"
end
