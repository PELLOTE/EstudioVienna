class CreateStyleGroups < ActiveRecord::Migration
  def change
    create_table :style_groups do |t|
      t.integer :group_id
      t.integer :music_style_id

      t.timestamps
    end
  end
end
