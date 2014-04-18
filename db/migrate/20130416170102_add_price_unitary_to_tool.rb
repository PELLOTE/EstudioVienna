class AddPriceUnitaryToTool < ActiveRecord::Migration
  def change
    add_column :tools, :price_unitary, :integer
  end
end
