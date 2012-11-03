class CreateJudges < ActiveRecord::Migration
  def change
    create_table :judges, {:primary_key => :judge_id} do |t|
      t.integer     :id
      t.string      :first_name
      t.string      :last_name
      t.string      :position
      t.string      :division
      t.string      :image_uri
      t.timestamps
    end
  end
end
