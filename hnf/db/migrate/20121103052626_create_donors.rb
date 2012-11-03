class CreateDonors < ActiveRecord::Migration
  def self.up
    create_table :donors do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :donors
  end
end
