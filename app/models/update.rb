class Update < ActiveRecord::Base
  set_table_name :updates
  set_primary_key :update_id

  validates_presence_of :title, :message => "_Title of the update can't be blank"
  validates_presence_of :details, :message => "_Details of the update can't be blank"
end
