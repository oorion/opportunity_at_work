class Admin::StaticPages::StaticPagesController < ApplicationController

  def learn_more
    @pdf = Pdf.learn_more
    @contents = Content.where(page: "learn more")
  end

  def techhire_locations
    @techhire_locations = TechhireLocation.all
  end

  def home
    @contents = Content.where(page: "home")
    @videos   = Video.where(page: "video")
  end

  def tools_resources
    @contents = Content.where(page: "tools_resources")
    @videos = Video.where(page: "tools_resources")
  end
end
