class CompaniesController < ApplicationController
  def index
    @companies = Company.all.sort_by(&:name)
  end

  def show
    @company = Company.find(params[:id])
  end
  
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.email_domain = @company.user_email[/\@(.*)/]
    if @company.save
      redirect_to @company
    else
      render :new
    end
  end

  private

  def company_params
    params.require(:company)
          .permit(:name, :cnpj, :address, :user_email)
  end
end