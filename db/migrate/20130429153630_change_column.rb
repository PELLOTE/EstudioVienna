class ChangeColumn < ActiveRecord::Migration
  def up
  	change_column :articles, :body, :text
  end

  def down
  end
end
