class FavoritesController < ApplicationController
  before_action :require_user_logged_in 
  
  def create
    room = Room.find(params[:room_id])
    current_user.favorite(room)
    flash[:success] = "お気に入りに登録しました。"
    redirect_to root_url
  end

  def destroy
    room = Room.find(params[:room_id])
    current_user.unfavorite(room)
    flash[:success] = "お気に入りを解除しました。"
    redirect_to root_url
  end
end
