class Admin::StaticPages::ToolsResourcesController < ApplicationController
  def edit
    @contents = Content.where(page: "tools_resources")
    @videos = Video.where(page: "tools_resources")
  end
end
