require "rails_helper"

RSpec.feature "Company Signup Page", type: :feature do
  describe "As a guest user, I" do
    include Capybara::DSL

    let! (:state) {
      State.create(
                   abbr: "CO",
                     id: 14
                  )
    }

    let! (:usa_city1) {
      UsaCity.create(
                     name: "Denver",
                 state_id: 14
                    )
    }

    let! (:usa_city2) {
      UsaCity.create(
                     name: "Boulder",
                 state_id: 14
                    )
    }

    let! (:usa_city3) {
      UsaCity.create(
                     name: "Dallas",
                 state_id: 13
                    )
    }

    it "can see links to signup and learn more on the home page" do
      visit ('/')
      within(".links") do
        expect(page).to have_link("Sign Up")
        expect(page).to have_link("Learn More")
      end
    end

    it "can see a form on the signup page" do
      visit ('/signup')
      within(".signup_form") do
          expect(page).to have_content("Start hiring")
        within("#new_company") do
          expect(page).to have_content("Name (First and Last)")
          expect(page).to have_content("Organization")
          expect(page).to have_content("Title")
          expect(page).to have_content("State")
          expect(page).to have_content("City")
          expect(page).to have_content("Email")
          find_button("Create techHire account")
        end
      end
    end

    it "can signup their company using the signup form" do
      visit signup_path
      within("#new_company") do
        fill_in 'company[name]', with: "Bob"
        fill_in 'company[organization]', with: "Google"
        fill_in 'company[title]', with: "RoR Developer"
        select('CO', from: 'company[state]')
        select('Denver', from: 'company[city]')
        fill_in 'company[email]', with: "google@email.com"
        check 'company[hiring]'
        fill_in 'company[hire_count]', with: 5
        click_button('Create techHire account')
      end

      expect(current_path).to eq(companies_welcome_path)
      expect(page).to have_content("Welcome Google")
      expect(page).to have_content("Please check your email to confirm your account.  We will reach out to you shortly.")
    end

    it "can not signup a company if email validation fails" do
      visit ('/signup')
      within("#new_company") do
        fill_in 'company[name]', with: "Bob"
        fill_in 'company[organization]', with: "Google"
        fill_in 'company[title]', with: "RoR Developer"
        select('CO', from: 'company[state]')
        select('Boulder', from: 'company[city]')
        fill_in 'company[email]', with: "goog"
        check 'company[hiring]'
        fill_in 'company[hire_count]', with: 5
        click_button('Create techHire account')
      end
      expect(current_path).to eq(companies_path)
      expect(page.find('.errors')).to have_content("Please try again!")
    end

    it "can see dynamically generated cities" do
      visit ('/signup')
      within("#new_company") do
        select('CO', from: 'company[state]')
        expect(page).to have_content("Boulder")
        expect(page).not_to have_content("Dallas")
      end
    end
  end
end
