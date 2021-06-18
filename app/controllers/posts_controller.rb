class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to controller: 'rooms', action: 'show', id: params[:post][:room_id]
    else
      @room = Room.find(params[:post][:room_id])
      @posts = current_user.posts.page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'rooms/show'
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = "メッセージを削除しました。"
    redirect_back(fallback_location: root_path)
  end

  private
  
  def post_params
    params.require(:post).permit(:user_id, :room_id, :content)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
