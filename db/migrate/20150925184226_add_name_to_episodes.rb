class AddNameToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :name, :string
  end
end
