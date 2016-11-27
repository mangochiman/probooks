class Tracker < ActiveRecord::Base
  set_table_name :trackers
  set_primary_key :tracker_id

  belongs_to :user, :foreign_key => :user_id

  def self.track_user(user_id, ip_address)
    tracker = Tracker.new
    tracker.user_id = user_id
    tracker.ip_address = ip_address
    tracker.save
  end
  
end
