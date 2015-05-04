require 'rails_helper'

RSpec.feature "AdminContentManagement", type: :feature do
  it "should be able to add new content" do
    visit "admin/contents"
    fill_in "content[title]", with: "This is a 10+ char descriptive title"
    fill_in "content[body]", with: "My body is ready."
    click_button "Submit"

    expect(page).to have_content("Content successfully created.")
    within(".table") do
      expect(page).to have_selector("#table-row", count:1)
      expect(page).to have_content("This is a 10+ char descriptive title")
      expect(page).to have_content("My body is ready.")
    end
    expect(current_path).to eql(admin_contents_path)
  end

  it "should not be able to add content with title under 10 char" do
    visit "admin/contents"
    fill_in "content[title]", with: "Too short"
    fill_in "content[body]", with: "My body is ready."
    click_button "Submit"

    expect(page).to have_content("The min title length is 10 characters.")
    expect(page).to_not have_selector("#table-row", count: 2)
  end

  it "should not be able to add content with a 60+ char title" do
    visit "admin/contents"
    fill_in "content[title]", with: "a" * 61
    fill_in "content[body]", with: "My body is ready."
    click_button "Submit"

    expect(page).to have_content("The max title length is 60 characters.")
  end

  it "should not be able to add content with blank body" do
    visit "admin/contents"
    fill_in "content[title]", with: "This is a 10+ char descriptive title"
    fill_in "content[body]", with: ""
    click_button "Submit"

    expect(page).to have_content("The body can't be blank.")
  end

  it "should not be able to add duplicate content" do
    content1 = create(:content)
    visit "admin/contents"
    fill_in "content[title]", with: "This is a 10+ char descriptive title2"
    fill_in "content[body]", with: content1.body
    click_button "Submit"

    expect(page).to have_content("There cannot be duplicate bodies.")
  end

  it "should not be able to add duplicate title" do
    content1 = create(:content)
    visit "admin/contents"
    fill_in "content[title]", with: content1.title
    fill_in "content[body]", with: "Body"
    click_button "Submit"

    expect(page).to have_content("There cannot be duplicate titles.")
    expect(page).to have_selector("#table-row", count: 1)
  end
end
