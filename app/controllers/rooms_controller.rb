class RoomsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:update, :edit]

  def show
    @room = Room.find(params[:id])
    @post = current_user.posts.build
    @posts = @room.posts.all
  end
  
  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      flash[:success] = 'トークルームを作成しました。'
      redirect_to @room
    else
      @rooms = current_user.rooms.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'トークルーム作成に失敗しました。'
      render 'rooms/new'
    end
  end
  
  def edit
    @room = Room.find(params[:id])
  end
  
  def update
    @room = Room.find(params[:id])
    
    if @room.update(room_params)
      flash[:success] = "ルーム情報を正常に更新しました"
      redirect_to root_path
    else
      flash.now[:danger] = '更新できませんでした'
      render :edit
    end
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
