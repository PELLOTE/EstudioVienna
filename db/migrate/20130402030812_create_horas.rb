class CreateHoras < ActiveRecord::Migration
  def change
    create_table :horas do |t|
      t.string :name
      t.integer :endTime
      t.integer :startTime

      t.timestamps
    end
  end
end
