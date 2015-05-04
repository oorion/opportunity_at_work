class Admin::VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def create
    video = Video.new(video_params)
    if video.save
      flash[:notice] = "Video succesfully uploaded"
      redirect_to admin_videos_path
    else
      flash[:error] = video.errors.messages.values[0][0]
      redirect_to admin_videos_path
    end
  end

  private

  def video_params
    params.require(:video).permit(:url, :title)
  end
end
