class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    if cannot? :manage, User
      redirect_to chats_path, alert: "Not authorized"
      return
  end

  def show
    @user = User.find(params[:id])
  end
  
  def newS
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)    
      redirect_to @user 
    else
      render :edit, status: :unprocessable_entity  
    end  
  end
  
  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
end
