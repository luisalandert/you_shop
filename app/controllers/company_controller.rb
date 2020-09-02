class CompanyController < ApplicationController
  def index
    @companies = Company.all.sort_by(&:name)
  end
  def show
    @company = Company.find(params[:id])
  end
end