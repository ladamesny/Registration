class UsersController < ApplicationController
  before_action :check_login, :only =>[:index]
  def index

  end

  def show
  end

  def new
    @user = User.new
    render :layout => false
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:status] = true
      flash[:alert] = "Eureeka! You've successfully registered..."
    else
      flash[:status] = false
      flash[:alert] = @user.errors.full_messages
    end
    redirect_to register_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :image, :password, :password_confirmation)
  end

  
end
