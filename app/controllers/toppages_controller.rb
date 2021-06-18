class ToppagesController < ApplicationController
  def index
    if logged_in?
      @rooms = Room.all.order(id: :desc).page(params[:page]) #一覧表示用
    end
  end
end
