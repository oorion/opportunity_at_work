class Admin::DashboardController < ApplicationController
  before_action :authorize!

  def index
    @uncontacted_companies = Company.paginate(:page => params[:page],
                                              :per_page => 5
                                              ).uncontacted
                                               .order("updated_at asc")
  end

  def cms_instructions
  end

  def new_admin
    @user = User.new
  end

  def create_admin
    binding.pry
  end

  private

  def admin_params
    params.require(:user).permit(:email)
  end
end
