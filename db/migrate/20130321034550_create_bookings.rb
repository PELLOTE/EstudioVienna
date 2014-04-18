class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.date :fecha
      t.integer :amount
      t.string :estate
      t.integer :room_id

      t.timestamps
    end
  end
end
