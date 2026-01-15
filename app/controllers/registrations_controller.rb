class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = 'user' # Default role
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Account created successfully!'
    else
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
