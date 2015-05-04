class Admin::StaticPages::LearnMoreController < ApplicationController
  def edit
    @pdf = Pdf.learn_more
    @contents = Content.where(page: "learn more")
  end
end
