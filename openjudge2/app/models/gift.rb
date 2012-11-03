class Gift < ActiveRecord::Base
  attr_accessible :description, :value, :date_given, :address_raw, :latitude, :longitude
  belongs_to :donor
  belongs_to :judge
end
