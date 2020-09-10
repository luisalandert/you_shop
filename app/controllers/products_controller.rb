class ProductsController < ApplicationController
before_action :authenticate_user!, only:[:index]

  def index
    users = User.where(company: current_user.company)
    @products = Product.where(user: users)
  end
end