class UsersController < ApplicationController
  skip_before_filter :authenticate_user, :only => [:login, :authenticate]
  def login
    @school_name = GlobalProperty.find_by_property("school_name") rescue nil
    # @settings = school_setting
    render :layout => false
  end

  def logout
    session[:current_user_id] = nil
    flash[:notice] = "You have been logged out"
    redirect_to("/login") and return
  end

  def authenticate
    user = User.find_by_username(params['username'])
    logged_in_user = User.authenticate(params[:username], params[:password])
    if logged_in_user
      session[:current_user_id] = user.id

      redirect_to("/") and return
    else
      flash[:error] = "Invalid username or password"
      redirect_to :controller => "user", :action => "login" and return
    end
  end


  def user_management_menu
    @users = User.find(:all)
  end

  def user_management_dashboard
  end

  def new_user
    @users = User.find(:all)
  end

  def edit_user
    if (params[:user_id])
      @user = User.find(params[:user_id])
    end
    @users = User.find(:all)

  end

  def void_users
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

    user = User.new
    user.first_name = first_name
    user.last_name = last_name
    user.email = email
    user.phone_number = phone_number
    user.password = password
    user. username = username

    if user.save
      flash[:notice] = "You have created your account. You may now login"
      redirect_to("/login") and return
    else
      flash[:error] = user.errors.full_messages.join('<br />')
      redirect_to("/login") and return
    end

  end

  def update_user_data
    if params[:user_id].blank?
      flash[:error] = "You didn't select any user to edit. Select user first"
      redirect_to :controller => "user", :action => "edit_user" and return
    end
    user = User.find(params[:user_id])
    first_name = params[:first_name]
    last_name = params[:last_name]
    password = params[:password]
    password_confirm = params[:password_confirm]
    if (password != password_confirm)
      flash[:error] = "Password mismatch."
      redirect_to :controller => "user", :action => "edit_user", :user_id => params[:user_id] and return
    end
    if (user.update_attributes({
            :first_name => first_name,
            :last_name => last_name,
            :username => params[:username],
            :password => params[:password]
          }))
      flash[:notice] = "Operation successful"
      redirect_to :controller => "user", :action => "edit_user" and return
    else
      flash[:error] = "Oops. Something wen't wrong. That's what we know"
      redirect_to :controller => "user", :action => "edit_user" and return
    end
  end

  def delete_users
    if (params[:mode] == 'single_entry')
      user = User.find(params[:user_id])
      user.delete
      render :text => "true" and return
    end

    user_ids = params[:user_ids].split(",")
    (user_ids || []).each do |user_id|
      user = User.find(user_id)
      user.delete
    end

    render :text => "true" and return
  end

  def user_account_settings_menu
    @user = User.find(session[:current_user_id])
  end

  def update_account
    @user = User.find(session[:current_user_id])

    if params[:edit_mode] == 'username'
      user = User.find_by_username(params[:username])
      unless user.blank?
        unless (user.id == @user.id)
          flash[:error] = "Unable to save. Username is already in use."
          redirect_to :controller => "user", :action => "user_account_settings_menu", :edit_mode => "username" and return
        end
      end
      if @user.update_attributes({
            :username => params[:username]
          })
        flash[:notice] = "Operation successful"
        redirect_to :controller => "user", :action => "user_account_settings_menu" and return
      end
    end

    if params[:edit_mode] == 'password'
      if (User.authenticate(@user.username, params[:password]))
        if (params[:new_password] == params[:repeat_password])
          @user.password = params[:new_password]
          @user.save
          flash[:notice] = "Operation successful"
          redirect_to :controller => "user", :action => "user_account_settings_menu" and return
        else
          flash[:error] = "Unable to save. New Password and Repeat password mismatch"
          redirect_to :controller => "user", :action => "user_account_settings_menu" and return
        end
      else
        flash[:error] = "Unable to save. Old password is not correct"
        redirect_to :controller => "user", :action => "/user_account_settings_menu", :edit_mode => "password" and return
      end
    end

    if params[:edit_mode] == 'first_name'
      if @user.update_attributes({
            :first_name => params[:first_name]
          })
        flash[:notice] = "Operation successful"
        redirect_to :controller => "user", :action => "user_account_settings_menu" and return
      else
        flash[:error] = "Unable to save. Check for erros and try again"
        redirect_to :controller => "user", :action => "user_account_settings_menu" and return
      end
    end

    if params[:edit_mode] == 'last_name'
      if @user.update_attributes({
            :last_name => params[:last_name]
          })
        flash[:notice] = "Operation successful"
        redirect_to :controller => "user", :action => "user_account_settings_menu" and return
      else
        flash[:error] = "Unable to save. Check for erros and try again"
        redirect_to :controller => "user", :action => "user_account_settings_menu" and return
      end
    end

    if params[:edit_mode] == 'names'
      if @user.update_attributes({
            :first_name => params[:first_name],
            :last_name => params[:last_name]
          })
        flash[:notice] = "Operation successful"
        redirect_to :controller => "user", :action => "user_account_settings_menu" and return
      else
        flash[:error] = "Unable to save. Check for erros and try again"
        redirect_to :controller => "user", :action => "user_account_settings_menu" and return
      end
    end
  end

  def reset_password
    email = params[:email]
    flash[:notice] = "An E-mail has been sent to <b>#{email}. Check your email</b>"
    redirect_to("/login") and return
  end
  
end
