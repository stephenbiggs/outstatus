class UsersController < ApplicationController

  before_action :make_sure_logged_in, only: [:edit, :update, :destroy]

  def index
    if logged_in?
      @user = current_user
    end
    @users = User.all.order('firstname ASC')
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    @user.status = "In office"

    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = "Please confirm your email address to continue"
      
      redirect_to root_path
    else
      flash[:error] = "Ooooppss, something went wrong!"
      render 'new'
    end
  end


  def edit
    @user = current_user
  end


  def update
    @user = current_user
    if @user.update(user_params)
      update_parking
      redirect_to root_path
    else
      render 'edit'
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy
    reset_session
    flash[:success] = "Your account has been deleted"
    redirect_to root_path
  end


  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to signin_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end


  def release_space
    @taken_space = Carspace.find_by_taken_user_id(current_user.id)
    @taken_space.taken_user_id = nil
    @taken_space.status = "Available"
    @taken_space.save!
    flash[:success] = "Parking space released"
    redirect_to root_path
  end



  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :status, :comments, :firstname, :lastname)
  end

end
