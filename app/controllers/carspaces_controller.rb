class CarspacesController < ApplicationController

  before_action :make_sure_logged_in

  def index
    @carspaces = Carspace.all.order('created_at ASC')
  end


  def use_space
    @user = current_user
    @space = Carspace.find(params[:id])

    if @space.taken_user_id == nil
      @space.taken_user_id = @user.id
      @space.status = "Unavailable"
      @space.save
      flash[:success] = "You have taken the parking space"
    else
      flash[:error] = "The parking space is not available"
    end
    redirect_to carspaces_path
  end

end
