class CreateDonors < ActiveRecord::Migration
  def self.up
    create_table :donors do |t|
      t.string      :name
      t.string      :association
      t.string      :address_raw
      t.float       :latitude
      t.float       :longitude
      t.string      :image_uri
      t.timestamps
    end
  end

  def self.down
    drop_table :donors
  end
end
