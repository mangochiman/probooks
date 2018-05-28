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
    digest_category_id = Category.find_by_name("DIGEST").category_id

    @primary_books_category = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", 
      :conditions => ["category_id =? AND book_id NOT IN (?)", primary_category_id, selected_book_ids])
    @secondary_books_category = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", 
      :conditions => ["category_id =? AND book_id NOT IN (?)", secondary_category_id, selected_book_ids])
    @tertiary_books_category = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)",
      :conditions => ["category_id =? AND book_id NOT IN (?)", tertiary_category_id, selected_book_ids])
    @reades_digest_books_category = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)",
      :conditions => ["category_id =? AND book_id NOT IN (?)", digest_category_id, selected_book_ids])

    @catalogs = Catalog.all
    @posters = Poster.all
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
  
  def update_my_catalog_shelf
    student_catalog = StudentCatalog.new
    student_catalog.user_id = session[:user].user_id
    student_catalog.catalog_id = params[:catalog_id]
    if student_catalog.save
      flash[:notice] = "Your operation is successful"
      redirect_to("/dashboard") and return
    else
      flash[:error] = "Unable to complete your request"
      redirect_to("/select_books_from_store") and return
    end
  end

  def update_my_poster_shelf
    student_poster = StudentPoster.new
    student_poster.user_id = session[:user].user_id
    student_poster.poster_id = params[:poster_id]
    if student_poster.save
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
      flash[:info] = "Your operation was successful"
      redirect_to("/dashboard") and return
    else
      flash[:info] = "Unable to process your request"
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
    @faculty_books = @faculty.books
    @user = User.find(session[:user].user_id)
    @page_title = "#{@faculty.name} Books"
  end

  def search_results
    @user = User.find(session[:user].user_id)
    @page_title = "Search Results"
    @books_by_title = []
    @books_by_authors = []
    @books = []
    @search_term = ""
    unless params[:general_search].blank?
      search_term = params[:general_search]
      @search_term = search_term
      @books_by_title = Book.search_all_by_title(search_term)
      @books_by_authors = Book.search_all_by_authors(search_term)
    end

    unless params[:search_type].blank?
      search_term = params[:search_words]
      @search_term = search_term
      unless search_term.blank?
        if params[:search_type] == 'author'
          @books_by_authors = Book.search_all_by_authors(search_term)
        end
        if params[:search_type] == 'title'
          @books_by_title = Book.search_all_by_title(search_term)
        end
        if params[:search_type] == 'all'
          @books_by_title = Book.search_all_by_title(search_term)
          @books_by_authors = Book.search_all_by_authors(search_term)
        end
      end
    end

    @books = (@books_by_title + @books_by_authors).uniq
  end

  def save_user_notes
    uri_referrer = request.referer
    user_note = UserNote.new
    user_note.data = params[:notes]
    user_note.user_id = session[:user].user_id
    if user_note.save
      flash[:notice] = "You have successfully saved your notes"
      redirect_to(uri_referrer) and return
    else
      flash[:error] = user_note.errors.full_messages.collect{|m|m.split('_')[1]}.join('<br />')
      redirect_to(uri_referrer) and return
    end
  end

  def delete_user_notes
    uri_referrer = request.referer
    user_note = UserNote.find(params[:user_note_id])
    if user_note.delete
      flash[:notice] = "Notes successfully deleted"
      redirect_to(uri_referrer) and return
    else
      flash[:error] = "Unable to delete the selected notes"
      redirect_to(uri_referrer) and return
    end
  end

  def render_students_notes
    user_note = UserNote.find(params[:user_note_id])
    render :text => user_note.data and return
  end

  def read_headlines
    @news = News.find(params[:news_id])
    @user = User.find(session[:user].user_id)
    @page_title = "Headline: " + UserNote.trim(@news.title, 50)
  end

  def read_updates
    @update = Update.find(params[:update_id])
    @user = User.find(session[:user].user_id)
    @page_title = "Update: " + UserNote.trim(@update.title, 50)
  end

end
