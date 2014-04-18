class AddVraiableToAssistants < ActiveRecord::Migration
  def change
    add_column :assistants, :booking_id, :integer
  end
end
