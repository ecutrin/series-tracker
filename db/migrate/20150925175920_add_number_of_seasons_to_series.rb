class AddNumberOfSeasonsToSeries < ActiveRecord::Migration
  def change
    add_column :series, :number_of_seasons, :integer
  end
end
