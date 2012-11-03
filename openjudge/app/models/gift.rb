class Gift < ActiveRecord::Base
  belongs_to :donor
  belongs_to :judge
end
