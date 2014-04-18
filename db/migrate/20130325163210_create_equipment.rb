class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.string :tool
      t.string :trademark
      t.integer :quantity

      t.timestamps
    end
  end
end
