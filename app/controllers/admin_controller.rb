class AdminController < ApplicationController
  def upload_books_menu
    @page_title = "Upload Books"
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
