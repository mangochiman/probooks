class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books, :primary_key => :book_id do |t|
      t.string :title
      t.string :author
      t.binary :cover_photo, :limit => 50.megabyte
      t.binary :content, :limit => 50.megabyte
      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
