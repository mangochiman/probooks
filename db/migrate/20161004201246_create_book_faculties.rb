class CreateBookFaculties < ActiveRecord::Migration
  def self.up
    create_table :book_faculties do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :book_faculties
  end
end
