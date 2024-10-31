# frozen_string_literal: true

class Location < ApplicationRecord
  EARTH_RADIUS = {
    km: 6371.0,
    mi: 3958.8
  }.freeze

  validates_presence_of :latitude, :longitude

  class << self
    def distance_from_query(latitude, longitude, unit: :km)
      haversine = harversine_arel(latitude, longitude)
      complete_harversine = Arel.sql('2 * atan2(sqrt(:haversine), sqrt(1 - :haversine))', haversine:)

      [Arel.sql('(? * ?) as distance', complete_harversine, EARTH_RADIUS[unit]), Arel.sql('? as distance_unit', unit)]
    end

    def harversine_arel(latitude, longitude)
      lat2 = degree_to_radian(latitude)
      lat1 = degree_to_radian(Location.arel_table[:latitude])

      delta_latitude = Arel.sql('(? - ?)', lat2, lat1)
      delta_longitude = Arel.sql('(? - ?)', degree_to_radian(longitude),
                                 degree_to_radian(Location.arel_table[:longitude]))

      Arel.sql(haversine_formula_sql, delta_latitude:, delta_longitude:, lat1:, lat2:)
    end

    def haversine_formula_sql
      <<~SQL
        (
          pow(sin(:delta_latitude / 2), 2) +
          cos(:lat2)*
          cos(:lat1)*
          pow(sin(:delta_longitude / 2),  2)
        )
      SQL
    end

    def degree_to_radian(field)
      Arel.sql('(? * pi() / 180)', field)
    end
  end

  def closest_sitters(limit = 10)
    Person.sitters.closests(self).limit(limit)
  end
end
