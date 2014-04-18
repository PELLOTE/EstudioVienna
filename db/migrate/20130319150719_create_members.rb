class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :group_id
      t.string :name
      t.string :lastname
      t.string :surname
      t.string :instrument
      

      t.timestamps
    end
  end
end
