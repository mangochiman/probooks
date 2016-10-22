class CreateUserBooks < ActiveRecord::Migration
  def self.up
    create_table :user_books, :primary_key => :user_book_id do |t|
      t.integer :user_id
      t.integer :book_id
      t.timestamps
    end
  end

  def self.down
    drop_table :user_books
  end
end
