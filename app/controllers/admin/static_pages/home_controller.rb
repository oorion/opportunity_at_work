class Admin::StaticPages::HomeController < ApplicationController
  def edit
    @contents = Content.where(page: "home")
    @videos   = Video.where(page: "video")
  end
end
