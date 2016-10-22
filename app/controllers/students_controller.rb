class StudentsController < ApplicationController
  layout 'students'
  
  def dashboard
    @page_title = "Dashboard"
  end

  def select_books_from_store
    @page_title = "Book Store"
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books_category = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books_category = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books_category = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])
  end

  def update_my_book_shelf

  end
  
  def remove_books_from_shelf_menu
    @page_title = "Remove Books"
  end

  def delete_books_from_menu

  end
  
  def my_recent_books_menu
    @page_title = "Recent Books"
  end

  def extras
    @page_title = "Extras"
  end

  def my_account
    @page_title = "My Account"
  end

end
