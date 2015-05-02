class Admin::CompaniesController < ApplicationController
  before_action :authorize!

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def destroy
    Company.find(params[:id]).destroy
    redirect_to admin_companies_path
  end

  def update
    company = Company.find(params[:id])
    if company.update(status: params[:company][:status]) && company.update(update_params)
      redirect_to admin_company_path(company.id)
    elsif company.update(status: params[:company][:status])
      redirect_to admin_company_path(company.id)
    else
      flash[:errors] = "Please try again!"
      render :edit
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  private

  def update_params
    params.require(:company).permit(:name, :organization, :title,
                                 :email, :state, :city, :hire_count)
  end
end
