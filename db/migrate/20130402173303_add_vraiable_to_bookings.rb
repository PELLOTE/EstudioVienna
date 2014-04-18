class AddVraiableToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :assistant_id, :integer
  end
end
