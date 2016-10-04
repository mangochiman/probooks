class CreateBookCategories < ActiveRecord::Migration
  def self.up
    create_table :book_categories do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :book_categories
  end
end
