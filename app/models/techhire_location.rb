class TechhireLocation < ActiveRecord::Base
  include ActiveModel::Dirty
  validates :city, presence: true
  validates :state, presence: true

  geocoded_by :full_address

  after_validation :geocode, if: ->(obj){(obj.longitude.blank? || obj.latitude.blank?)} || ->(obj){(obj.city_changed? || obj.state_changed?)}

  after_validation :must_have_coordinates

  def full_address
    "#{city}, #{state}"
  end

  def d3_coordinates
    slice(:city, :longitude, :latitude)
  end

  def must_have_coordinates
    if self.latitude.blank? || self.longitude.blank?
      errors.add(:error, "Our geocoder cannot determine the coordinates of that location.")
    end
  end
end
