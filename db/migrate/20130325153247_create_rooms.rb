class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :room_id
      t.integer :price
      t.integer :max

      t.timestamps
    end
  end
end
