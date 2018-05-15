class CreateStudentCatalogs < ActiveRecord::Migration
  def self.up
    create_table :student_catalogs, :primary_key => :student_catalog_id do |t|
      t.integer :user_id
      t.integer :catalog_id
      t.timestamps
    end
  end

  def self.down
    drop_table :student_catalogs
  end
end
