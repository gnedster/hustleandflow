class Gift < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :donor
  belongs_to :judge
end
