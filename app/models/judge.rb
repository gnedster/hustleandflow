class Judge < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many  :gifts
  has_many  :donors, :through => :gifts

  def full_name
    "#{self.first_name.titlecase} #{self.last_name.titlecase}"
  end

  def total_value
    self.gifts.inject(0){|sum, x| sum + (x.value||0) }
  end

  def gift_count
    self.gifts.count
  end
end
