class Faculty < ActiveRecord::Base
  set_table_name :faculties
  set_primary_key :faculty_id

  has_many :book_faculties, :dependent => :destroy
  validates_presence_of :name, :message => "can't be blank"
  validates_uniqueness_of :name, :message => "already exists"
  
end
