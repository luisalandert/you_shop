class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @products = @user.products
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      if profile_complete?(@user)
        @user.complete!
        redirect_to @user, notice: 'Perfil atualizado com sucesso!'
      else
        @user.incomplete!
        redirect_to @user, notice: 'Perfil atualizado com sucesso! Atenção: para ter acesso a todos os recursos seu perfil deve estar completo!'
      end
    else
      @user = User.find(params[:id])
      render :edit
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:full_name, :social_name, :birth_date, :job_position, :department)
  end

  def profile_complete?(user)
    return false if !user.full_name.present?||!user.social_name.present?||!user.birth_date.present?||
                    !user.job_position.present?||!user.department.present?
    return true
  end
end