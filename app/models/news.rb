class News < ActiveRecord::Base
  set_table_name :news
  set_primary_key :news_id

  validates_presence_of :title, :message => "_Headline can't be blank"
  validates_presence_of :data, :message => "_Content can't be blank"
  
end
