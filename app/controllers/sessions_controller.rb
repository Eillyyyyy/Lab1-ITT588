class SessionsController < ApplicationController
  def new
  end

  # Process the login credentials submitted by the user
  def create
    username = params[:username]
    password = params[:password]
    authenticated = false
    user_role = nil

    # Read the Password.txt file line by line to check user info
    File.foreach(Rails.root.join("Password.txt")) do |line|
      user, pass, role = line.chomp.split(',')
      
      # chcek if pass and username match
      if user == username && pass == password
        authenticated = true
        user_role = role
        break 
      end
    end

    # Redirect based on whether login was successful
    if authenticated
      session[:user_id] = username 
      flash[:notice] = "Login successful! Welcome, #{username}."
      redirect_to root_path 
    else
      flash[:error] = "Invalid username or password."
      redirect_to login_path
    end
  end

  # Handle user logout by clearing the session
  def destroy
    session[:user_id] = nil 
    flash[:notice] = "You have logged out."
    redirect_to login_path 
  end
end