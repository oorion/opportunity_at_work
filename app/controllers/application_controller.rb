class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if current_user && current_user.admin?
      admin_dashboard_index_path
    elsif current_user && current_user.company?
      binding.pry
      company_path(current_user.company.id)
    else
      root_path
    end
  end

  def authorize!
    unless current_user && current_user.admin?
      redirect_to root_path
    end
  end
end
