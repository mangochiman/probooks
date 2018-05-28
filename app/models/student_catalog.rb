class StudentCatalog < ActiveRecord::Base
  set_table_name :student_catalogs
  set_primary_key :student_catalog_id

  belongs_to :catalog, :foreign_key => :catalog_id
end
