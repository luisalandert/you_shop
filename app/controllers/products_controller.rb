class ProductsController < ApplicationController
before_action :authenticate_user!, only:[:index, :show, :new, :create, :edit, :update]

  def index
    users = User.where(company: current_user.company)
    @products = Product.where(user: users)
  end

  def show
    @product = Product.find(params[:id])
  end
  
  def new
    @product = Product.new
    @categories = Category.all
  end
  
  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save && current_user.complete?
      redirect_to @product
    else
      @categories = Category.all
      if !current_user.complete?
        redirect_to edit_user_path(current_user), alert: 'Complete seu perfil para poder registrar produtos.'
        return
      else
        render :new
        return
      end
    end
  end

  private 

  def product_params
    params.require(:product)
          .permit(:name, :description, :category_id, :price, :condition, :quantity, :picture, :user_id)
  end

end