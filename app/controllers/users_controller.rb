class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  def show # 追加
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following_users.page(params[:page]).per(10).order(:id)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.follower_users.page(params[:page]).per(10).order(:id)
    render 'show_follow'
  end
  
  def favorite
    @title = 'Favorite Microposts'
    @micropost = current_user.microposts.build
    @feed_items = current_user.favorite_microposts.page(params[:page]).per(10)
    render template: 'static_pages/home'
  end

  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :profile, :location)
  end
  
end
