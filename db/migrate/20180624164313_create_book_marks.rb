class CreateBookMarks < ActiveRecord::Migration
  def self.up
    create_table :book_marks, :primary_key => :book_mark_id do |t|
      t.integer :user_id
      t.string :link
      t.timestamps
    end
  end

  def self.down
    drop_table :book_marks
  end
end
