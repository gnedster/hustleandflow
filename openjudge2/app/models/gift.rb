class Gift < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :donor
  belongs_to :judge

  def donor
    Donor.where(:id => self.donor_id)
  end

  def judge
    Judge.where(:id => self.judge_id)
  end
end
