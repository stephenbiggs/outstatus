class DesksController < ApplicationController

  before_action :make_sure_logged_in

  def index
    @days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    @slots = Desk.all
    @t = DateTime.now
    @next_week = DateTime.now.beginning_of_week(start_day = :monday) + 7
  end


  def book_desk
    @desk = Desk.find(params[:id])
    @desk.user = current_user
    @desk.save!
    flash[:success] = "You have booked a desk"
    redirect_to desks_path
  end


  def cancel_desk
    @desk = Desk.find(params[:id])
    @desk.user = nil
    @desk.save!
    flash[:success] = "You have cancelled a desk booking"
    redirect_to desks_path
  end


end
