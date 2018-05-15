class Catalog < ActiveRecord::Base
  set_table_name :catalogs
  set_primary_key :catalog_id

  def uploaded_file=(data)
    self.filename = data.original_filename
    self.content_type = data.content_type
    self.content = data.read
  end

  def filename=(new_filename)
    write_attribute("filename", sanitize_filename(new_filename))
  end

  private
  def sanitize_filename (filename)
    #get only the filename, not the whole path (from IE)
    just_filename = File.basename(filename)
    #replace all non-alphanumeric, underscore or periods with underscores
    just_filename.gsub(/[^\w\.\-]/, '_')
  end
end
