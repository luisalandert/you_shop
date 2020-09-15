class ProductsController < ApplicationController
before_action :authenticate_user!, only:[:index, :show, :new, :create, :edit, :update]

  def index
    users = User.where(company: current_user.company)
    @products = Product.where(user: users, status: :available)
  end

  def show
    @product = Product.find(params[:id])
    if !@product.available? && (current_user.id != @product.user.id)
      redirect_to products_path, alert: 'Produto indisponível!'
    end

    @comments = Comment.where(product: @product)
    @comment = Comment.new

    @messages = @product.messages
    if !@messages.empty?
      @users = []
      @messages.each do |m|
        if m.sender.id != @product.user.id
          @users << m.sender
        end
      end
      @users.uniq!
      if current_user.id == @product.user.id
        @available_messages = @messages
      else
        sent_messages = @messages.where(sender: current_user)
        received_messages = @messages.where(sender: @product.user, recipient: current_user)
        @available_messages = (received_messages + sent_messages).sort_by { |obj| obj.created_at }
      end
    end
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

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params) && current_user.complete?
      redirect_to @product, alert: 'Produto atualizado com sucesso!'
    else
      if !current_user.complete?
        redirect_to edit_user_path(current_user), alert: 'Complete seu perfil para poder registrar produtos.'
      end
      @product = Product.find(params[:id])
      @categories = Category.all
      flash[:alert] = 'Todos os campos devem estar preenchidos!'
      render :edit
    end
  end

  def search
    users = User.where(company: current_user.company)
    all_products = Product.where(user: users, status: :available)
    @products = all_products.where('name LIKE ?', "%#{params[:q]}%")
    render :index
  end

  def suspend
    product = Product.find(params[:id])
    product.suspended!
    redirect_to product_path(product.id), notice: 'Produto suspenso!'
  end

  def activate
    product = Product.find(params[:id])
    product.available!
    redirect_to product_path(product.id), notice: 'Produto ativado!'
  end

  private 

  def product_params
    params.require(:product)
          .permit(:name, :description, :category_id, :price, :condition, :quantity, :picture, :user_id)
  end

end