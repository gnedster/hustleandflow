class CreateGiftTypes < ActiveRecord::Migration
  def change
    create_table :gift_types do |t|
      t.integer     :id
      t.string      :gift_type
      t.timestamps
    end

    add_foreign_key :gifts, :gift_types
  end
end
