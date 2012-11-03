class Judge < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many  :gifts
  has_many  :donors, :through => :gifts
end
