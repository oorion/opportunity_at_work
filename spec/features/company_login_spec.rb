require 'rails_helper'

RSpec.feature "Company Login", type: :feature do
  it "should allow a user to sign in and see their associated company profile" do
    company = create(:company)
    visit new_user_session_path

    fill_in 'user[email]', with: company.users.first.email
    fill_in 'user[password]', with: 'password'
    click_link_or_button('Log in')

    expect(current_path).to eq(company_path(company.id))
    expect(page).to have_content(company.organization)
    expect(page).to have_content(company.city)
    expect(page).to have_content(company.state)
    expect(page).to have_content(company.hire_count)
    company.users.each do |user|
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.title)
      expect(page).to have_content(user.email)
    end
  end
end
