class StaticPagesController < ApplicationController
  layout "static_application"

  def home
  end

  def learn_more
  end

  def tools_resources
    @pdf_learn_more = Pdf.learn_more
  end

  def techhire_locations
    @techhire_locations = TechhireLocation.all
  end
end
