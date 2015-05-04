require 'rails_helper'

RSpec.feature "AdminPdfManagements", type: :feature do
  it "can upload a pdf" do
    visit 'admin/pdfs'
    attach_file "pdf[pdf_file]", Rails.root.join('spec', 'fixtures', 'sample_pdf.pdf')
    click_button "Submit"

    expect(page).to have_content("Pdf successfully uploaded")
    expect(current_path).to eql(admin_pdfs_path)
  end

  it "should not allow nothing to be uploaded" do
    visit 'admin/pdfs'
    click_button "Submit"

    expect(page).to have_content("PDF cannot be blank")
    expect(current_path).to eql(admin_pdfs_path)
  end

  it "should not allow a non-pdf to be uploaded" do
    visit 'admin/pdfs'
    attach_file "pdf[pdf_file]", Rails.root.join('spec', 'fixtures', 'whitehouse_jpeg.jpeg')
    click_button "Submit"

    expect(page).to have_content("Only pdf files are allowed.")
    expect(current_path).to eql(admin_pdfs_path)

    attach_file "pdf[pdf_file]", Rails.root.join('spec', 'fixtures', 'whitehouse_png.png')
    click_button "Submit"

    expect(page).to have_content("Only pdf files are allowed.")
  end

  it "should not allow a duplicate pdf to be uploaded" do
    pdf = create(:pdf)

    visit 'admin/pdfs'
    attach_file "pdf[pdf_file]", Rails.root.join('spec', 'fixtures', 'sample_pdf.pdf')
    click_button "Submit"

    expect(page).to have_content("You already uploaded a pdf with this name.")
    expect(current_path).to eql(admin_pdfs_path)
    # expect(page).to have_selector("#table-row", count:2)
  end

  describe("an admin can manage pdfs") do
    let(:admin) do
      User.create(email: 'admin@example.com', password: 'password', role: 1)
    end

    def login
      visit new_user_session_path
      fill_in 'user[email]', with: admin.email
      fill_in 'user[password]', with: admin.password
      click_link_or_button('Log in')
    end

    it "can view the details of a pdf" do
      pdf_file = Rack::Test::UploadedFile.new('spec/fixtures/sample_pdf.pdf', 'application/pdf')
      pdf = Pdf.create(slot: 98, pdf_file: pdf_file)
      login
      visit admin_pdfs_path
      expect(page).to have_content(98)
      expect(page).to have_content('sample_pdf.pdf')
      expect(page).to have_content(pdf.id)
    end

    it "can delete a pdf" do
      pdf_file = Rack::Test::UploadedFile.new('spec/fixtures/sample_pdf.pdf', 'application/pdf')
      pdf = Pdf.create(slot: 98, pdf_file: pdf_file)
      login
      visit admin_pdfs_path
      click_link_or_button("Delete")
      expect(page).to_not have_content(98)
      expect(page).not_to have_content('sample_pdf.pdf')
      expect(page).to_not have_content(pdf.id)
    end

    # it "views links to all pdfs on the admin/pdfs" do
    #   pdf_file1 = Rack::Test::UploadedFile.new('spec/fixtures/sample_pdf1.pdf', 'application/pdf')
    #   pdf_file2 = Rack::Test::UploadedFile.new('spec/fixtures/sample_pdf2.pdf', 'application/pdf')
    #   pdf1 = Pdf.create(slot: 98, pdf_file: pdf_file1)
    #   pdf2 = Pdf.create(slot: 99, pdf_file: pdf_file2)
    #   login
    #   visit admin_pdfs_path
    #   expect(page).to have_link(pdf1.pdf_file_file_name)
    #   expect(page).to have_link(pdf2.pdf_file_file_name)
    # end
  end
end
