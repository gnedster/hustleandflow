class Donor < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many  :gifts
  has_many  :judges, :through => :gifts

end
