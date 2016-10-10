class CreateBookFaculties < ActiveRecord::Migration
  def self.up
    create_table :book_faculties, :id => false do |t|
      t.integer :book_id
      t.integer :faculty_id
      t.timestamps
    end
  end

  def self.down
    drop_table :book_faculties
  end
end
