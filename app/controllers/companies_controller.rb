class CompaniesController < ApplicationController
  before_action :authenticate_user!, only:[:show]
  
  def index
    @companies = Company.all.sort_by(&:name)
  end

  def show
    @company = Company.find(params[:id])
  end
  
  def new
    if user_signed_in?
      redirect_to root_path, alert: 'Sua empresa já está cadastrada.
      Para cadastrar outra empresa faça o log out e use o email corporativo da nova empresa.'
    end
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.email_domain = @company.user_email[/\@(.*)/]
    if @company.save
      redirect_to new_user_registration_path
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