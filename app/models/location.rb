class Location < ApplicationRecord
  EARTH_RADIUS_KM = 6371.0

  def distance_from(location)
    delta_latitude = location.radian_latitude - radian_latitude
    delta_longitude = location.radian_longitude - radian_longitude

    a = (Math.sin(delta_latitude / 2) * Math.sin(delta_latitude / 2)) +
    (Math.cos(radian_latitude) * Math.cos(location.radian_latitude) *
    Math.sin(delta_longitude / 2) * Math.sin(delta_longitude / 2))
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    EARTH_RADIUS_KM * c
  end

  def radian_latitude
    self.class.deg_to_rad(latitude)    
  end

  def radian_longitude
    self.class.deg_to_rad(longitude)    
  end

  private

  def self.deg_to_rad(degrees)
    degrees * Math::PI / 180
  end
end
