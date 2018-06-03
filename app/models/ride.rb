class Ride < ApplicationRecord
  has_one :driver
  has_and_belongs_to_many :users
  acts_as_mappable :default_units => :kms,
                   :lat_column_name => :start_point_lat,
                   :lng_column_name => :start_point_lng
end


