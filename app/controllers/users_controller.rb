class UsersController < ApplicationController
  
  admin_access_only except: [:show]
  
  def index
  end
  
  def show
    @user = User.find(params[:id])
    unless @user.indulge?(current_user, :read)
      flash['alert'] = 'Access denied'
      redirect_to root_path
    end
  end

  def new
  end
  
  def create
    
  end

  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end

end
