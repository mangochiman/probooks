class UsersController < ApplicationController
  #skip_before_filter :authenticate_user, :only => [:login, :authenticate, :create, :reset_password]
  #skip_before_filter :access_denied, :only => [:access_denied]
  
  def login
    #@school_name = GlobalProperty.find_by_property("school_name") rescue nil
    # @settings = school_setting
    render :layout => false
  end

  def logout
    reset_session #Destroy all sessions
    flash[:notice] = "You have been logged out. Bye"
    redirect_to("/login") and return
  end

  def authenticate
    user = User.find_by_username(params['username'])
    logged_in_user = User.authenticate(params[:username], params[:password])

    if logged_in_user
      session[:user] = user
      ip_address = request.remote_ip
      Tracker.track_user(user.user_id, ip_address)
      redirect_to("/dashboard") and return if user.role == 'user'
      redirect_to("/") and return
    else
      flash[:error] = "Invalid username or password"
      redirect_to("/login") and return
    end
  end


  def user_management_menu
    @users = User.find(:all)
  end

  def new_user
    @users = User.find(:all)
  end


  def view_users
    @users = User.find(:all)
  end

  def create
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    phone_number = params[:phone_number]
    username = params[:username]
    password = params[:password]
    password_confirm = params[:confirm_password]

    if (password != password_confirm)
      flash[:error] = "Password Mismatch"
      redirect_to("/login") and return
    end
    salt = User.random_string(10)

    user = User.new
    user.first_name = first_name
    user.last_name = last_name
    user.email = email
    user.phone_number = phone_number
    user.password = User.encrypt(password, salt)
    user.salt = salt
    user.username = username

    if user.save
      new_user_role = UserRole.new
      new_user_role.username = user.username
      new_user_role.role = 'user'
      new_user_role.save
      flash[:notice] = "You have created your account. You may now login"
      redirect_to("/login") and return
    else
      flash[:error] = user.errors.full_messages.join('<br />')
      redirect_to("/login") and return
    end

  end

  def update_account_details
    @user = User.find(session[:user].user_id)
    
    if params[:field_type] == 'first_name'
      if @user.update_attributes({
            :first_name => params[:first_name]
          })
        flash[:notice] = "You have successfully updated your first name"
        redirect_to("/my_account") and return
      else
        flash[:error] = "Unable to process your request"
        redirect_to("/my_account") and return
      end
    end

    if params[:field_type] == 'last_name'
      if @user.update_attributes({
            :last_name => params[:last_name]
          })
        flash[:notice] = "You have successfully udated your last name"
        redirect_to("/my_account") and return
      else
        flash[:error] = "Unable to process your request"
        redirect_to("/my_account") and return
      end
    end

    if params[:field_type] == 'phone'
      if @user.update_attributes({
            :phone_number => params[:phone_number]
          })
        flash[:notice] = "You have successfully updated your phone number"
        redirect_to("/my_account") and return
      else
        flash[:error] = "Unable to process your request"
        redirect_to("/my_account") and return
      end
    end

    if params[:field_type] == 'email'
      if @user.update_attributes({
            :email => params[:email]
          })
        flash[:notice] = "You have successfully updated your email"
        redirect_to("/my_account") and return
      else
        flash[:error] = "Unable to process your request"
        redirect_to("/my_account") and return
      end
    end

    if params[:field_type] == 'username'
      if @user.update_attributes({
            :username => params[:username]
          })
        flash[:notice] = "You have successfully updated your username"
        redirect_to("/my_account") and return
      else
        flash[:error] = "Unable to process your request"
        redirect_to("/my_account") and return
      end
    end

    if params[:field_type] == 'password'
      if (User.authenticate(@user.username, params[:old_password]))
        if (params[:new_password] == params[:repeat_password])
          @user.password = User.encrypt(params[:new_password], @user.salt)
          @user.save
          flash[:notice] = "You have successfully updated your password. Your new password is <b>#{params[:new_password]}</b>"
          redirect_to("/my_account") and return
        else
          flash[:error] = "Unable to save. New Password and Confirmation password does not match"
          redirect_to("/my_account") and return
        end
      else
        flash[:error] = "Unable to save. Old password is not correct"
        redirect_to("/my_account") and return
      end
    end
    
  end
  
  def reset_password
    email = params[:email]
    flash[:notice] = "An E-mail has been sent to <b>#{email}. Check your email</b>"
    redirect_to("/login") and return
  end

  def create_account_by_admin
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    phone_number = params[:phone_number]
    username = params[:username]
    password = params[:password]
    password_confirm = params[:confirm_password]

    if (password != password_confirm)
      flash[:error] = "Password Mismatch"
      redirect_to("/new_users_menu") and return
    end
    salt = User.random_string(10)
    
    user = User.new
    user.first_name = first_name
    user.last_name = last_name
    user.email = email
    user.phone_number = phone_number
    user.salt = salt
    user.password = User.encrypt(password, salt)
    user. username = username

    if user.save
      user_role = UserRole.new
      user_role.username = user.username
      user_role.role = params[:user_role]
      user_role.save
      flash[:notice] = "You have successfully created an account."
      redirect_to("/new_users_menu") and return
    else
      flash[:error] = user.errors.full_messages.join('<br />')
      redirect_to("/new_users_menu") and return
    end
  end

  def access_denied
    render :layout => false
  end
  
end
