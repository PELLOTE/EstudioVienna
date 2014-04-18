class CreateBookingTimes < ActiveRecord::Migration
  def change
    create_table :booking_times do |t|
      t.integer :booking_id
      t.integer :hora_id

      t.timestamps
    end
  end
end
