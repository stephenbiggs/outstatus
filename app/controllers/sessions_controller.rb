class SessionsController < ApplicationController

  def new

  end

  def create
    @email = params[:session][:email]
    @password = params[:session][:password]

    @user = User.find_by_email(@email)

    if @user.present? and @user.authenticate(@password)

      if @user.email_confirmed
        flash[:success] = "You are logged in"
        session[:uid] = @user.id
        redirect_to root_path
      else
        flash[:error] = "Please activate your account by following the 
        instructions in the account confirmation email you received to proceed"
        render 'new'
      end

    else
      flash[:error] = "Your details are incorrect"
      render 'new'
    end
  end


  def destroy
    reset_session
    flash[:success] = "You are now signed out"
    redirect_to root_path
  end


end
