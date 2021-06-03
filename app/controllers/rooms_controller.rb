class RoomsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def show
    @room = Room.find(params[:id])
  end
  
  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      flash[:success] = 'トークルームを作成しました。'
      redirect_to root_url
    else
      @rooms = current_user.rooms.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'トークルーム作成に失敗しました。'
      render 'rooms/new'
    end
  end

  def destroy
    @room.destroy
    flash[:success] = 'トークルームを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  
  private
  
  def room_params
    params.require(:room).permit(:name, :introduction)
  end
  
  def correct_user
    @room = current_user.rooms.find_by(id: params[:id])
    unless @room
      redirect_to root_url
    end
  end
end
