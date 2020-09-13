class ProposalsController < ApplicationController
  def show
    @proposal = Proposal.find(params[:id])
  end
  
  def new
    @proposal = Proposal.new
    @products = Product.available
  end

  def create
    @proposal = Proposal.new(proposal_params)
      @proposal.buyer = current_user
      if !params[:proposal][:product_id].blank?
        @proposal.seller = @proposal.product.user
      end
    if @proposal.save && current_user.complete?
      redirect_to @proposal
    else
      @products = Product.available
      if !current_user.complete?
        redirect_to edit_user_path(current_user), alert: 'Complete seu perfil para poder fazer propostas.'
        return
      else
        render :new
        return
      end
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:product_id, :proposed_price, :quantity)
  end
end