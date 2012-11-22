class Judge < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many  :gifts
  has_many  :donors, :through => :gifts

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def total_value
    self.gifts.inject(0){|sum, x| sum + x.value }.to_s
  end
end
