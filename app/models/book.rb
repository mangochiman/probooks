class Book < ActiveRecord::Base
  set_table_name :books
  set_primary_key :book_id

  has_many :book_categories, :dependent => :destroy
  has_many :book_faculties, :dependent => :destroy
  has_many :faculties, :through => :book_faculties
  has_many :user_books, :dependent => :destroy
  has_many :users, :through => :user_books
  #validates_format_of :cover_photo, :with => %r{\.(png|jpg|jpeg)$}i, :message => "whatever"
  #validates_format_of :content_type, :with => ["application/pdf"], :message => "Only PDFs are supported"
  validates_format_of :content_type, :with => /pdf$/, :message => "_Only books that are in pdf format are supported"
  validates_format_of :cover_photo_content_type, :with => /^image/, :message => "_Only images are supported as book covers"

  def uploaded_file=(data)
    book = data[0]
    cover_photo = data[1]
    self.filename = book.original_filename
    self.content_type = book.content_type
    self.content = book.read
    self.cover_photo = cover_photo.read
    self.cover_photo_content_type = cover_photo.content_type #cover_photo_file_name
    self.cover_photo_file_name = cover_photo.original_filename
  end

  def filename=(new_filename)
    write_attribute("filename", sanitize_filename(new_filename))
  end

  def cover_photo_file_name=(new_filename)
    write_attribute("cover_photo_file_name", sanitize_filename(new_filename))
  end
  
  private
  def sanitize_filename (filename)
    #get only the filename, not the whole path (from IE)
    just_filename = File.basename(filename)
    #replace all non-alphanumeric, underscore or periods with underscores
    just_filename.gsub(/[^\w\.\-]/, '_')
  end
end
