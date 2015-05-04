class Admin::DashboardController < ApplicationController
  before_action :authorize!

  def index
    @uncontacted_companies = Company.paginate(:page => params[:page],
                                              :per_page => 5
                                              ).uncontacted
                                               .order("updated_at asc")
  end
end
