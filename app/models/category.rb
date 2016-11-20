class Category < ActiveRecord::Base
  set_table_name :categories
  set_primary_key :category_id

  has_many :book_categories
  validates_uniqueness_of :name

  def display_name
    if self.name == 'DIGEST'
      return "Readers Digest"
    else
      return self.name
    end
  end
end
