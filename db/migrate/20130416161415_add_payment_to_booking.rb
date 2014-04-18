class AddPaymentToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :payment, :integer
  end
end
