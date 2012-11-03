class CreateGifts < ActiveRecord::Migration
  def self.up
    create_table :gifts do |t|
      t.string      :description
      t.decimal     :value
      t.date        :date_given
      t.string      :address_raw
      t.decimal     :latitude
      t.decimal     :longitude
      t.string      :image_uri
      t.integer     :donor_id
      t.integer     :judge_id
      t.timestamps
    end

    add_foreign_key :gifts, :donor
    add_foreign_key :gifts, :judge
  end

  def self.down
    drop_table :gifts
  end
end
