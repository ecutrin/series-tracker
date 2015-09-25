class AddShowIdToSeries < ActiveRecord::Migration
  def change
    add_column :series, :show_id, :string
    add_index :series, :show_id, unique: true
  end
end
