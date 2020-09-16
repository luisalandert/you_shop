class MessagesController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    content = params[:content]
    recipient = params[:recipient]
    @message = Message.new(content: content)
    @message.sender = current_user
    if !recipient.blank?
      @message.recipient = User.find(recipient)
    else
      @message.recipient = @product.user
    end
    @message.product = @product
    if @message.save
      redirect_back(fallback_location: product_path(@product))
    end
  end

  private

  def message_params
    params.permit(:content, :recipient)
    # TODO: pq não tem a chave :message?
  end
end