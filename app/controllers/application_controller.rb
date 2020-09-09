class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_companies


  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:company_id])
    end

  def set_companies
    @companies = Company.all
  end



  # before_action :teste_function

  # def teste_function
  #   @teste = 'hello world'
  # end
end
