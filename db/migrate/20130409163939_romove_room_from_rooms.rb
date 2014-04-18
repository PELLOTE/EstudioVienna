class RomoveRoomFromRooms < ActiveRecord::Migration
  def self.up
    remove_column :rooms, :room_id
  end

  def self.down
    add_column :rooms, :room_id, :integer
  end
end
