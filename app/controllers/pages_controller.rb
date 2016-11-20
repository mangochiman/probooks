class PagesController < ApplicationController
  before_filter :check_admin_role
  def home
    @page_title = "Home"
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id
    digest_category_id = Category.find_by_name("DIGEST").category_id

    @primary_category_id = primary_category_id
    @secondary_category_id = secondary_category_id
    @tertiary_category_id = tertiary_category_id
    @readers_digest_category_id = digest_category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])
    @readers_digest_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", digest_category_id])
  end
  
end
