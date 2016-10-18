class AdminController < ApplicationController
  def upload_books_menu
    @page_title = "Upload Books"
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])
    @book_categories = Category.all.collect{|c|[c.name, c.name]}
    @faculties = Faculty.all.collect{|f|[f.name, f.faculty_id]}
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

      (params[:faculty] || []).each do |faculty_id|
        book_faculty = BookFaculty.new
        book_faculty.book_id = book.book_id
        book_faculty.faculty_id = faculty_id
        book_faculty.save
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
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])

    @books = Book.all
  end

  def remove_books_menu
    @page_title = "Remove Books"
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])

    @books = Book.all
  end

  def delete_book
    book = Book.find(params[:book_id])
    book_title = book.title
    book_author = book.author

    if (book.delete)
      flash[:notice] = "You have successfully deleted book titled <b>#{book_title}</b> by <b><i>#{book_author}</i></b>"
      redirect_to("/remove_books_menu/") and return
    else
      flash[:error] = book.errors.full_messages.join('<br />')
      redirect_to("/remove_books_menu/") and return
    end
    
  end

  def new_faculties_menu
    @page_title = "New Faculty"
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])
    
    @faculties = Faculty.all
  end

  def edit_faculties_menu
    @page_title = "Edit Faculties"
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])
    
    @faculties = Faculty.all
  end

  def edit_faculty
    @faculties = Faculty.all
    @faculty = Faculty.find(params[:faculty_id])
    @page_title = "Editing #{@faculty.name}"
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])
  end

  def update_faculty
    faculty = Faculty.find(params[:faculty_id])
    faculty.name = params[:faculty_name]
    if faculty.save
      flash[:notice] = "You have successfully updated a faculty"
      redirect_to("/edit_faculty/#{params[:faculty_id]}") and return
    else
      flash[:error] = faculty.errors.full_messages.join('<br />')
      redirect_to("/edit_faculty/#{params[:faculty_id]}") and return
    end
  end

  def delete_faculty
    faculty = Faculty.find(params[:faculty_id])
    faculty_name = faculty.name
    if (faculty.delete)
      flash[:notice] = "You have successfully delete faculty of <b>#{faculty_name}</b>"
      redirect_to("/remove_faculties_menu/") and return
    else
      flash[:error] = faculty.errors.full_messages.join('<br />')
      redirect_to("/remove_faculties_menu/") and return
    end
  end

  def view_faculties_menu
    @faculties = Faculty.all
    @page_title = "View Faculties"
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])
  end

  def remove_faculties_menu
    @page_title = "Remove Faculties"
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])
    @faculties = Faculty.all
  end

  def new_users_menu
    @page_title = "New User"
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])
  end

  def edit_users_menu
    @page_title = "Edit User"
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])
  end

  def view_users_menu
    @page_title = "View Users"
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])

    @users = User.find(:all, :conditions => ["user_id != ?", session[:user].user_id])
  end

  def remove_users_menu
    @page_title = "Remove Users"
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])
  end

  def browse_by_category
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])

    category = Category.find(params[:category_id])
    @page_title = "Browse Books By Category: #{category.name}"
    @selected_category_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", params[:category_id]])

  end

  def edit_user
    @user = User.find(params[:user_id])
    @page_title = "Editing #{@user.username}"
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])
  end

  def delete_user
    if request.post?
      user = User.find(params[:user_id])
      username = user.username
      if user.delete
        flash[:notice] = "you have successfully deleted <b>#{username}'s</b> account"
        redirect_to("/view_users_menu")
      else
        flash[:notice] = "Unable to delete <b>#{username}'s</b> account"
        redirect_to("/view_users_menu")
      end
    end
  end

  def update_account_by_admin
    @user = User.find(params[:user_id])
    if @user.update_attributes({
          :first_name => params[:first_name],
          :last_name => params[:last_name],
          :phone_number => params[:phone_number],
          :email => params[:email]
        })
      flash[:notice] = "You have successfully edited <b>#{@user.username}'s </b> account"
      redirect_to("/view_users_menu") and return
    else
      flash[:error] = "Failed to update the account <b>#{@user.username}</b>"
      redirect_to("/view_users_menu") and return
    end
  end

  def view_by_faculty
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id

    @primary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", primary_category_id])
    @secondary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", secondary_category_id])
    @tertiary_books = BookCategory.find(:all, :joins => "INNER JOIN books USING (book_id)", :conditions => ["category_id =?", tertiary_category_id])

    @faculty = Faculty.find(params[:faculty_id])
    @faculty_books = @faculty.books
    book_text = "Books"
    book_text = "Book" if @faculty_books.count == 1
    @page_title = "#{@faculty.name} (#{@faculty_books.count} #{book_text})"
  end

end
