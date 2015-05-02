require 'rails_helper'

RSpec.feature "AdminPdfManagements", type: :feature do
  it "can upload a pdf" do
    visit 'admin/pdfs'
    attach_file "pdf[pdf_file]", Rails.root.join('spec', 'fixtures', 'sample_pdf.pdf')
    click_button "Submit"

    expect(page).to have_content("Pdf successfully uploaded")
    within(".table") do
      expect(page).to have_css("#table-row", text: "sample_pdf.pdf")
      expect(page).to have_selector("tr", count: 2, visible: true)
    end
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
end
