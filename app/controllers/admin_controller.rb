class AdminController < ApplicationController
  def upload_books_menu
    @page_title = "Upload Books"
    @book_categories = Category.all.collect{|c|[c.name, c.category_id]}
  end

  def create_book
    book = Book.new
    book.uploaded_file = ([params[:book], params[:book_cover]])
    book.title = params[:book_title]
    book.author = params[:book_author]
    if book.save
      
      params[:book_category].each do |category_id|
        book_category = BookCategory.new
        book_category.book_id = book.book_id
        book_category.category_id = category_id
        book_category.save
      end

      flash[:notice] = "You have successfully uploaded a book"
      redirect_to("/upload_books_menu")
    else
      flash[:error] = book.errors.full_messages.join('<br />')
      redirect_to("/upload_books_menu")
    end
  end
  
  def view_books_menu
    @page_title = "View Books"
  end

  def remove_books_menu
    @page_title = "Remove Books"
  end

  def new_faculties_menu
    @page_title = "New Faculty"
  end

  def edit_faculties_menu
    @page_title = "Edit Faculties"
  end

  def view_faculties_menu
    @page_title = "View Faculties"
  end

  def remove_faculties_menu
    @page_title = "Remove Faculties"
  end

  def new_users_menu
    @page_title = "New User"
  end

  def edit_users_menu
    @page_title = "Edit User"
  end

  def view_users_menu
    @page_title = "View Users"
  end

  def remove_users_menu
    @page_title = "Remove Users"
  end
  
end
