class CompaniesController < ApplicationController
  before_action :authorize_company!, only: [:show]

  def new
    @company = Company.new
  end

  def show
    @company = Company.find(params[:id])
  end

  def create
    company = Company.new(company_params)
    if company.save
      flash[:success] = "Welcome #{company.organization}"
      redirect_to companies_welcome_path
    else
      flash[:error] = "Please try again!"
      @company = Company.new
      render :new
    end
  end

  def welcome
  end

  private

  def company_params
    temp = params.require(:company).permit(:name,
                                    :organization,
                                    :title,
                                    :state,
                                    :city,
                                    :email,
                                    :hiring,
                                    :hire_count )
    temp[:hire_count] = "0" if temp[:hire_count] == ""
    temp
  end
end
