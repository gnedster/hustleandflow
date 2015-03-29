class Donor < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many  :gifts
  has_many  :judges, :through => :gifts

  def total_value
    self.gifts.inject(0){|sum, x| sum + (x.value||0) }
  end

  def gift_count
    self.gifts.count
  end

end
