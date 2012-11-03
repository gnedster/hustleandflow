class CreateDonors < ActiveRecord::Migration
  def change
    create_table :donors do |t|
      t.string      :name
      t.string      :association
      t.string      :address_raw
      t.decimal     :latitude
      t.decimal     :longitude
      t.string      :image_uri
      t.timestamps
    end
  end
end
