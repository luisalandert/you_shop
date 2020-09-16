class ProposalsController < ApplicationController
  
  def index
  end

  def received
    @proposals = current_user.received_proposals
  end

  def sent
    @waiting_proposals = current_user.sent_proposals.waiting
    @approved_proposals = current_user.sent_proposals.approved
    @denied_proposals = current_user.sent_proposals.denied
  end

  def rejected
    @proposals = current_user.received_proposals.denied
  end
  
  def cancelled
    @cancelled_proposals = current_user.sent_proposals.cancelled
  end
  
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

  def accept
    proposal = Proposal.find(params[:id])
    remaining_quantity = proposal.product.quantity - proposal.quantity
    if remaining_quantity >= 0
      Product.find(proposal.product.id).update(quantity: remaining_quantity)
      if Product.find(proposal.product.id).quantity == 0
        Product.find(proposal.product.id).unavailable!
      end
      proposal.approved!
      invoice = Invoice.new(proposal: proposal, seller: proposal.seller, buyer: proposal.buyer, issue_date: Time.zone.now)
      if invoice.save
        redirect_to invoice_path(invoice), notice: 'Venda finalizada com sucesso!'
      end
    else
      redirect_to proposal, alert: 'Produto com quantidade insuficiente para aceitar a proposta!'
    end
  end

  def deny
    proposal = Proposal.find(params[:id])
    proposal.denied!
    invoice = Invoice.new(proposal: proposal, seller: proposal.seller, buyer: proposal.buyer, issue_date: Time.zone.now)
    if invoice.save
      redirect_to received_proposals_path, notice: 'Proposta recusada!'
    end
  end

  def cancel
    proposal = Proposal.find(params[:id])
    proposal.cancelled!
    invoice = Invoice.new(proposal: proposal, seller: proposal.seller, buyer: proposal.buyer, issue_date: Time.zone.now)
    if invoice.save
      redirect_to sent_proposals_path, notice: 'Proposta cancelada!'
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:product_id, :proposed_price, :quantity)
  end
end