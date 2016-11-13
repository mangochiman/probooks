# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def logged_in_user_details
    user = User.find(session[:user].user_id)
    user_names = user.first_name + ' ' + user.last_name
    return user_names
  end

  def faculties
    faculties = Faculty.all
    return faculties
  end

  def primary_category_id
    primary_category_id = Category.find_by_name("PRIMARY").category_id
    return primary_category_id
  end

  def secondary_category_id
    secondary_category_id = Category.find_by_name("SECONDARY").category_id
    return secondary_category_id
  end

  def tertiary_category_id
    tertiary_category_id = Category.find_by_name("TERTIARY").category_id
    return tertiary_category_id
  end

  def user_notes
    user_id = session[:user].user_id
    user_notes = UserNote.find(:all, :conditions => ["User_id =?", user_id], :order => "user_note_id DESC")
    return user_notes
  end
  
end
