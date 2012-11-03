class CreateGifts < ActiveRecord::Migration
  def self.up
    create_table :gifts do |t|
      t.string      :description
      t.float       :value
      t.date        :date_given
      t.string      :address_raw
      t.float       :latitude
      t.float       :longitude
      t.string      :image_uri
      t.references  :donor
      t.references  :judge
      t.timestamps
    end
  end

  def self.down
    drop_table :gifts
  end
end
