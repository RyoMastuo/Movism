class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :update]
  def show
    @user = User.find(params[:id])
    @likes = @user.likes.order(id: :desc).page(params[:page])
    counts(@user)
  end
  
  def new
    @user = User.new
  end

  def create
     @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = "正常に更新しました"
      redirect_to @user
    else
      flash.now[:danger] = "更新できませんでした"
      render :edit
    end
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :email, :password, :password_confirmation)
  end
end
