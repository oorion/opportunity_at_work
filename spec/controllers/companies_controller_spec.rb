require 'rails_helper'

RSpec.describe CompaniesController, :type => :controller do

  it "can create a company" do
    company_params = {
                        name: 'Bob',
                organization: 'Google',
                       title: 'RoR',
                       state: 'CO',
                        city: 'Denver',
                       email: 'google@email.com',
                      hiring: 1,
                  hire_count: 5
                       }
    original_company_count = Company.count
    post :create, company: company_params
    assert_redirected_to companies_welcome_path
    expect(original_company_count + 1).to eq(Company.count)
  end
end
