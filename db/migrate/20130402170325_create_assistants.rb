class CreateAssistants < ActiveRecord::Migration
  def change
    create_table :assistants do |t|
      t.string :name
      t.string :lastname
      t.string :surname
      t.string :instrument
      t.string :nickname

      t.timestamps
    end
  end
end
