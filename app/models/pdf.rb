class Pdf < ActiveRecord::Base
  has_attached_file :pdf_file,
    :path => "public/assets/pdfs/:basename.:extension",
    :url => "public/assets/pdfs/:basename.:extension"


  validates_attachment_content_type :pdf_file,
                                    :content_type => [ 'application/pdf' ],
                                    :message => "Only pdf files are allowed.",
                                    :if => :pdf_attached?

  validates :pdf_file_file_name, uniqueness: {
                                message: "You already uploaded a pdf with this name."
                                }

  def self.learn_more
    where("slot = 1").first
  end

  def pdf_attached?
    self.pdf_file.present?
  end
end
