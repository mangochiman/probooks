class StudentsController < ApplicationController
  layout 'students'
  
  def dashboard
    @page_title = "Book Shelf"
    @user = User.find(session[:user].user_id)
    @my_books = @user.books
  end

  def select_books_from_store
    @page_title = "Book Store"
    user = User.find(session[:user].user_id)
    selected_book_ids = user.books.collect{|b|b.book_id}
    selected_book_ids = [0] if selected_book_ids.blank?

    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books_category = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", 
      :conditions => ["category_id =? AND book_id NOT IN (?)", primary_category_id, selected_book_ids])
    @secondary_books_category = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", 
      :conditions => ["category_id =? AND book_id NOT IN (?)", secondary_category_id, selected_book_ids])
    @tertiary_books_category = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)",
      :conditions => ["category_id =? AND book_id NOT IN (?)", tertiary_category_id, selected_book_ids])
  end

  def update_my_book_shelf
    user_book = UserBook.new
    user_book.user_id = session[:user].user_id
    user_book.book_id = params[:book_id]
    if user_book.save
      flash[:notice] = "Your operation is successful"
      redirect_to("/dashboard") and return
    else
      flash[:error] = "Unable to complete your request"
      redirect_to("/select_books_from_store") and return
    end
  end
  
  def remove_books_from_shelf_menu
    @page_title = "Remove Books"
  end

  def delete_books_from_my_shelf
    user_book = UserBook.find(:last, :conditions => ["book_id =? AND user_id =?",
        params[:book_id], session[:user].user_id])
    if user_book.delete
      flash[:notice] = "Your operation was successful"
      redirect_to("/dashboard") and return
    else
      flash[:error] = "Unable to process your request"
      redirect_to("/dashboard") and return
    end
  end
  
  def my_recent_books_menu
    @page_title = "Recent Books"
  end

  def extras
    @page_title = "Extras"
  end

  def my_account
    @page_title = "My Account"
    @user = User.find(session[:user].user_id)
  end

  def select_books_by_faculty
    @faculty = Faculty.find(params[:faculty_id])
    @page_title = "#{@faculty.name} Books"
  end

  def search_results
    @page_title = "Search Results"
  end
  
end
