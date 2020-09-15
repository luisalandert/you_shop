class InvoicesController < ApplicationController
  def index
    @received_invoices = current_user.received_invoices
  end
  
  def show
    @invoice = Invoice.find(params[:id])
  end

  def sent
    @sent_invoices = current_user.sent_invoices
  end

  def received
    @received_invoices = current_user.received_invoices
  end

end