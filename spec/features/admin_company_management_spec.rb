require 'rails_helper'

RSpec.feature "AdminCompanyManagement", type: :feature do
  describe("an admin can manage the contact details of a company") do
    let(:admin) do
      User.create(email: 'admin@example.com', password: 'password', role: 1)
    end

    def login
      visit new_user_session_path

      fill_in 'user[email]', with: admin.email
      fill_in 'user[password]', with: admin.password
      click_link_or_button('Log in')
    end

    it "can view the details of a company" do
      companies = create_list(:company, 5, status: "uncontacted")
      login
      visit admin_companies_path

      click_link(companies.first.organization, match: :first)

      expect(current_path).to eq(admin_company_path(companies.first.id))

      expect(page).to have_content(companies.first.organization)
      expect(page).to have_content(companies.first.users.first.name)
      expect(page).to have_content(companies.first.users.first.title)
      expect(page).to have_content(companies.first.users.first.email)
      expect(page).to have_content(companies.first.city)
      expect(page).to have_content(companies.first.state)
      expect(page).to have_content(companies.first.status.capitalize)
    end

    it "can delete a company" do
      companies = create_list(:company, 5, status: "uncontacted")
      login

      visit '/admin/companies'

      click_link(companies.first.organization, match: :first)

      expect(page).to have_button("Delete Company")

      click_button("Delete Company")

      expect(current_path).to eq(admin_companies_path)
      expect(Company.count).to eq(4)
    end

    it "can add notes to a contacted company" do
      companies = create_list(:company, 5, status: "contacted")
      login
      click_link_or_button("Companies")
      first(".Organization").click_link(companies.first.organization)
      within(".add_note") do
        fill_in "note", with: "test note"
      end
      click_link_or_button("Add Note")

      within(".notes") do
        expect(page).to have_content("test note")
      end
      expect(current_path).to eq(admin_company_path(companies.first.id))
    end

    it "views all companies on dashboard" do
      company1 = create(:company, status: "confirmed")
      company2 = create(:company, status: "contacted")
      company3 = create(:company, status: "uncontacted")
      company4 = create(:company, status: "dead")
      login

      visit '/admin/companies'

      expect(current_path).to eq(admin_companies_path)

      expect(page).to have_link(company1.organization)
      expect(page).to have_link(company2.organization)
      expect(page).to have_link(company3.organization)
      expect(page).to have_link(company4.organization)
    end

    it "can update the status of a company" do
      company = create(:company)
      login
      click_link("Companies")

      expect(current_path).to eq(admin_companies_path)
      click_link(company.organization)
      select "Contacted", from: "company_status"
      click_button("Update Status")

      expect(Company.first.status).to eq("contacted")
    end

    it "can edit a company information" do
      State.create(abbr: "WY", id: 51)
      UsaCity.create(name: "Laramie", state_id: 51)
      company = create(:company)
      login

      click_link("Companies")
      expect(current_path).to eq(admin_companies_path)

      click_link(company.organization)
      expect(page).to have_link("Edit Company")

      click_link("Edit Company")
      expect(current_path).to eq(edit_admin_company_path(company.id))

      fill_in "company[organization]", with: "Netflix"
      select "WY", from: "company[state]"
      select "Laramie", from: "company[city]"
      find(:css, "#company_hiring").set(false)
      fill_in "company[hire_count]", with: 7
      click_button("Submit")

      expect(current_path).to eq(admin_company_path(company.id))
      expect(page).to have_content("Netflix")
      expect(page).to have_content("WY")
      expect(page).to have_content("Laramie")
      expect(page).to have_content("7")
    end

    it "persists data on the edit page" do
      State.create(abbr: "WY", id: 51)
      State.create(abbr: "CO", id: 13)
      UsaCity.create(name: "Laramie", state_id: 51)
      UsaCity.create(name: "Denver", state_id: 13)
      company = create(:company)
      login

      click_link("Companies")
      click_link(company.organization)
      click_link("Edit Company")

      expect(page).to have_selector("input[value='Google']")
      expect( find(:css, 'select#company_state').value ).to eq('CO')
      expect( find(:css, 'select#company_city').value ).to eq('Denver')
      expect(page).to have_selector("input[value='5']")
    end
  end
end
