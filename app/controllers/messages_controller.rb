class MessagesController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @message = Message.new(message_params)
    @message.sender = current_user
    @message.recipient = @product.user
    @message.product = @product
    if @message.save
      redirect_back(fallback_location: product_path(@product))
    end
  end

  private

  def message_params
    params.permit(:content)
    # TODO: pq não tem a chave :message?
  end
end