class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:full_name, :social_name, :birth_date, :job_position, :department)
  end
end