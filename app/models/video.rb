class Video < ActiveRecord::Base
  validate :verify_youtube_video
  validates :title, uniqueness: { message: "Video title already exists."}
  validates :url, uniqueness: { message: "Video url already exists."}

  validates :slot, numericality: { only_integer: true,
                                   greater_than_or_equal_to: 1,
                                   less_than_or_equal_to: 4
                                  },
                                  allow_blank: true

  validates_inclusion_of :page, in: ["tools and resources",
                                      "learn more",
                                      "home",
                                      "techhire locations",
                                      "start hiring"],
                                message: "%{value} is not a valid page",
                                allow_blank: true

  def verify_youtube_video
    yt_regex = /www\.youtube\.com\/watch\?v=([a-zA-Z0-9_-]*)/

    if self.url.blank?
      errors[:error] << "Please enter a valid url."
    elsif !self.url.match(yt_regex)
      errors[:error] << "Please check your YouTube format."
    end
  end
end
