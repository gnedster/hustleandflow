class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts, {:primary_key => :gift_id} do |t|
      t.integer     :id
      t.string      :description
      t.decimal     :value
      t.string      :type
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
end
