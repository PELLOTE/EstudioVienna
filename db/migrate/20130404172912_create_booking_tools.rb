class CreateBookingTools < ActiveRecord::Migration
  def change
    create_table :booking_tools do |t|
      t.integer :booking_id
      t.integer :tool_id

      t.timestamps
    end
  end
end
