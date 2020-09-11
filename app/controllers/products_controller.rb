class ProductsController < ApplicationController
before_action :authenticate_user!, only:[:index, :show, :new, :create]

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
    if @product.save
      redirect_to @product
    else
      @categories = Category.all
      render :new
    end
  end

  private 

  def product_params
    params.require(:product)
          .permit(:name, :description, :category_id, :price, :condition, :quantity, :picture, :user_id)
  end

end