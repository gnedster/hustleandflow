class CreateJudges < ActiveRecord::Migration
  def self.up
    create_table :judges do |t|
      t.string      :first_name
      t.string      :last_name
      t.string      :position
      t.string      :division
      t.string      :image_uri
      t.timestamps
    end
  end

  def self.down
    drop_table :judges
  end
end
