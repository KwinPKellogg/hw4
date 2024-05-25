class SessionsController < ApplicationController
  def new
  end

  def create
    # authenticate the user
    # try to find the user by their unique identifier
    @user = User.find_by({ "username" => params["username"] })
    # if the user exists -> check if they know their password
    if @user != nil
      # if they know their password -> login is successful
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome, #{@user["username"]}."
        redirect_to "/"
      else
        # if the user doesn't know their password -> login fails
        flash["notice"] = "Password Incorrect :("
        redirect_to "/login"
      end
    else
      # if the user doesn't exist -> login fails
      flash["notice"] = "Nope."
      redirect_to "/login"
    end
  end

  def destroy
    # logout the user
    flash["notice"] = "Goodbye :)"
    session["user_id"] = nil
    redirect_to "/login"
  end
end
  