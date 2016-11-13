class UserNote < ActiveRecord::Base
  set_table_name :user_notes
  set_primary_key :user_note_id

  belongs_to :user, :foreign_key => :user_id, :primary_key => :user_id
  validates_presence_of :data, :message => "_Notes can't be blank"

  def self.trim(data, size)
    if data.size > size
      return data[0..size].to_s.squish + ' ...'
    else
      return data
    end
  end

end
