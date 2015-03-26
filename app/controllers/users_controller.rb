class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

#  def index
#      unless current_user.admin?
#          redirect_to :back, :alert => "Access denied"
#      end
#      @users = User.all
#  end
#  
#  def show
#      @user = User.find(params[:id])
#      unless current_user.admin?
#          unless @user == current_user
#              redirect_to :back, :alert => "Access denied"
#          end
#      end
#  end

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end

end
