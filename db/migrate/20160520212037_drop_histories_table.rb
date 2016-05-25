class DropHistoriesTable < ActiveRecord::Migration
  def change
    drop_table :histories
  end
end
