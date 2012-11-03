class Donor < ActiveRecord::Base
  has_many  :gifts
  has_many  :judges, :through => :gifts
end
