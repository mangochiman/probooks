class AdminController < ApplicationController
  def upload_books_menu
    @page_title = "Upload Books"
    @book_categories = Category.all.collect{|c|[c.name, c.name]}
    @faculties = [['Info Science', 'Info Science'], ['Engineering', 'Engineering']]
  end

  def create_book
    book = Book.new
    book.uploaded_file = ([params[:book], params[:book_cover]])
    book.title = params[:book_title]
    book.author = params[:book_author]

    if book.save
      
      params[:book_category].each do |category_name|
        category_id = Category.find_by_name(category_name).category_id
        book_category = BookCategory.new
        book_category.book_id = book.book_id
        book_category.category_id = category_id
        book_category.save
      end
      
      book_id = book.book_id
      new_book_name = "#{book_id.to_s}.pdf"
      new_book_cover_name = "#{book_id.to_s}_cover_#{params[:book_cover].original_filename}"
      
      book_data = File.read(params[:book].path)
      book_cover_data = File.read(params[:book_cover].path)
      
      File.open(Rails.root.join('public', 'books', new_book_name), 'wb') do |file|
        file.write(book_data) #Create a book to a directory
      end

      File.open(Rails.root.join('public', 'books', new_book_cover_name), 'wb') do |file|
        file.write(book_cover_data) #Create a book cover to a directory
      end

      flash[:notice] = "You have successfully uploaded a book"
      redirect_to("/upload_books_menu")
    else
      #flash[:error] = book.errors.full_messages.join('<br />')
      flash[:error] = book.errors.full_messages.collect{|m|m.split('_')[1]}.join('<br />')
      redirect_to("/upload_books_menu")
    end
  end

  def create_faculty
    faculty = Faculty.new
    faculty.name = params[:faculty_name]
    if faculty.save
      flash[:notice] = "You have successfully added a faculty"
      redirect_to("/new_faculties_menu")
    else
      flash[:error] = faculty.errors.full_messages.join('<br />')
      redirect_to("/new_faculties_menu")
    end
  end
  
  def code_book
    book = Book.find(params[:book_id])
    send_data book.content, :filename => book.filename, :type => book.content_type, :disposition => "inline"
  end

  def view_books_menu
    @page_title = "View Books"
  end

  def remove_books_menu
    @page_title = "Remove Books"
  end

  def new_faculties_menu
    @page_title = "New Faculty"
    @faculties = Faculty.all
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
