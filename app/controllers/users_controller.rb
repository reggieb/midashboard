class UsersController < ApplicationController
  
  admin_access_only except: [:show]
  before_filter :get_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.indulgence(current_user, :read)
  end
  
  def show
    unless @user.indulge?(current_user, :read)
      flash['alert'] = 'Access denied'
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new
    update_user
  end

  def edit
    render :new
  end
  
  def update
    update_user
  end
  
  def destroy
    @user.destroy
    flash[:notice] = "User deleted"
    redirect_to users_path
  end
  
  private
  def get_user
    @user = User.find(params[:id])
  end
  
  def update_user
    Rails.logger.debug "Got here!!!!!!!!!!!!!!!!!!!"
    @user.attributes = params[:user]
    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

end
