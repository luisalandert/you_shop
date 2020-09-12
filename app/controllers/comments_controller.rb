class CommentsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.product = @product
    if @comment.save
      redirect_back(fallback_location: product_path(@product))
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end