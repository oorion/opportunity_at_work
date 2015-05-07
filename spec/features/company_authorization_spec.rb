require 'rails_helper'

  RSpec.feature "Company Profile Authorization", type: :feature do
  it "should allows a user to see their profile" do
    company = create(:company)
    visit new_user_session_path

    fill_in 'user[email]', with: company.users.last.email
    fill_in 'user[password]', with: 'password'
    click_link_or_button('Log in')

    expect(current_path).to eq(company_path(company.id))
    expect(page).to have_content(company.organization)
  end

  it "should not allow a user to see other company profiles" do
    company = create(:company)
    other_company = create(:company, email: "other@example.com")
    visit new_user_session_path

    fill_in 'user[email]', with: company.users.first.email
    fill_in 'user[password]', with: 'password'
    click_link_or_button('Log in')
    visit company_path(other_company.id)

    expect(current_path).to eq(root_path)
    expect(page).to_not have_content(company.organization)
  end
end
