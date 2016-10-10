class CreateBookCategories < ActiveRecord::Migration
  def self.up
    create_table :book_categories, :id => false do |t|
      t.integer :book_id
      t.integer :category_id
      t.timestamps
    end
  end

  def self.down
    drop_table :book_categories
  end
end
