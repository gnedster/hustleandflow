class CreateDonors < ActiveRecord::Migration
  def change
    create_table :donors, {:primary_key => :id} do |t|
      t.integer     :id
      t.string      :name
      t.string      :affiliation
      t.string      :address_raw
      t.decimal     :latitude
      t.decimal     :longitude
      t.string      :image_uri
      t.timestamps
    end
  end
end
