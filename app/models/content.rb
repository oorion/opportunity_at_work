class Content < ActiveRecord::Base
  validates_length_of :title, within: 10..60,
                              too_short: "The min title length is 10 characters.",
                              too_long: "The max title length is 60 characters."
  validates :title, uniqueness: { message: "There cannot be duplicate titles." }

  validates :body, presence: { message: "The body can't be blank." },
                  uniqueness: { message: "There cannot be duplicate bodies." }
end
