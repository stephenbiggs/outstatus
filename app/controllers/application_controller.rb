class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  helper_method :current_user
  helper_method :logged_in?
  helper_method :get_user
  helper_method :space_taken?
  helper_method :get_slots

  def current_user
    @current_user = User.find(session[:uid])
  end

  def logged_in?
    session[:uid].present?
  end

  def make_sure_logged_in
    if not logged_in?
      flash[:error] = "You must be logged in to see that page"
      redirect_to root_path
    end
  end


  def get_user(user)
    @user = User.find_by_id(user)
  end

  def update_parking
    @user = current_user
    @user_space = Carspace.find_by_space_owner_id(@user.id)
    @taken_space = Carspace.find_by_taken_user_id(@user.id)

    if @user_space.present?
      # logic for users with allocated parking space here
      if @taken_space.present? && @taken_space == @user_space || @taken_space.blank? && @user_space.taken_user_id == nil
        if @user.status == "In office"
          @user_space.taken_user_id = @user.id
          @user_space.status = "Unavailable"
        elsif @user.status == "Home" || @user.status == "Holiday" || @user.status == "On site" || @user.status == "Remote working" 
          @user_space.taken_user_id = nil
          @user_space.status = "Available"
        end
        @user_space.save
      elsif @taken_space.present? && @taken_space != @user_space
        if @user.status == "Home" || @user.status == "Holiday" || @user.status == "On site" || @user.status == "Remote working" 
          @taken_space.taken_user_id = nil
          @taken_space.status = "Available"
        end
        @taken_space.save
      end
      
    else
      # logic for users without allocated parking space here
      if @taken_space.present? && (@user.status == "Home" || @user.status == "Holiday" || @user.status == "On site" || @user.status == "Remote working")
        @taken_space.taken_user_id = nil
        @taken_space.status = "Available"
        @taken_space.save
      end
    end

  end

end

# check if user already has a parking space in use
def space_taken? 
  @taken_space = Carspace.find_by_taken_user_id(current_user.id)
end


def get_slots(day, time)
  @day_slots = @slots.where(day: day, time_slot: time)
  return @day_slots
end