class Judge < ActiveRecord::Base
  has_many  :gifts
  has_many  :donors, :through => :gifts
end
