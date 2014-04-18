class RemoveFormBookigs < ActiveRecord::Migration
  def up
    remove_column :bookings, :assistant_id	
  end
 
  def down
    add_column :bookings, :assistant_id, :integer
  end
end
