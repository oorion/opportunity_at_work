class Admin::CompaniesController < ApplicationController
  before_action :authorize!

  def index
    @companies = Company.paginate(:page => params[:page])
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
    company.update(update_params)
    company.update(status: params[:company][:status])
    if company.save
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
