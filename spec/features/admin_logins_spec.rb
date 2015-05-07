require 'rails_helper'

RSpec.feature "AdminLogins", type: :feature do
  describe("Admin") do
    let(:admin) do
      User.create(email: 'admin1@example.com', password: 'password', role: 1)
    end

    it "allows admin to login" do
      visit new_user_session_path

      fill_in 'user[email]', with: admin.email
      fill_in 'user[password]', with: admin.password
      click_link_or_button('Log in')

      expect(current_path).to eq(admin_dashboard_index_path)
    end

    it "allows admin to view admin/companies" do
      visit new_user_session_path

      fill_in 'user[email]', with: admin.email
      fill_in 'user[password]', with: admin.password
      click_link_or_button('Log in')
      visit admin_companies_path

      expect(current_path).to eq(admin_companies_path)
    end

    it "allows admin to view admin/companies/:id" do
      company = create(:company)
      visit new_user_session_path

      fill_in 'user[email]', with: admin.email
      fill_in 'user[password]', with: admin.password
      click_link_or_button('Log in')
      visit admin_company_path(company.id)

      expect(current_path).to eq(admin_company_path(company.id))
    end
  end

  describe("Non-user") do
    it "doesn't allow non-users to login" do
      visit new_user_session_path

      fill_in 'user[email]', with: 'test@example.com'
      fill_in 'user[password]', with: 'password'
      click_link_or_button('Log in')

      expect(current_path).to eq(new_user_session_path)
    end

    it "doesn't allow non-users to view admin/dashboard" do
      visit admin_dashboard_index_path

      expect(current_path).to eq(root_path)
    end

    it "doesn't allow non-users to view admin/companies" do
      visit admin_companies_path

      expect(current_path).to eq(root_path)
    end

    it "doesn't allow non-users to view admin/companies/:id" do
      company = create(:company)
      visit admin_company_path(company.id)

      expect(current_path).to eq(root_path)
    end
  end

  describe("Normal User") do
    attr_reader :company

    before(:each) do
      allow(User).to receive(:generate_password).and_return("password")
      @company = create(:company, email: 'user@example.com')
    end

    it "doesn't allow non-admin users to route to admin/dashboard on login" do
      visit new_user_session_path

      fill_in 'user[email]', with: company.users.first.email
      fill_in 'user[password]', with: "password"
      click_link_or_button('Log in')

      expect(current_path).to eq(company_path(company.id))
    end

    it "doesn't allow non-admin users to login and view admin/dashboard" do
      visit new_user_session_path

      fill_in 'user[email]', with: company.users.first.email
      fill_in 'user[password]', with: "password"
      click_link_or_button('Log in')
      visit admin_dashboard_index_path

      expect(current_path).to eq(root_path)
    end

    it "doesn't allow non-admin users to login and view admin/companies" do
      visit new_user_session_path

      fill_in 'user[email]', with: company.users.first.email
      fill_in 'user[password]', with: "password"
      click_link_or_button('Log in')
      visit admin_companies_path

      expect(current_path).to eq(root_path)
    end

    it "doesn't allow non-admin users to login and view admin/companies/:id" do
      visit new_user_session_path

      fill_in 'user[email]', with: company.users.first.email
      fill_in 'user[password]', with: "password"
      click_link_or_button('Log in')
      visit admin_company_path(company.id)

      expect(current_path).to eq(root_path)
    end
  end
end
