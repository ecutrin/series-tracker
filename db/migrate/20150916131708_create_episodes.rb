class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.belongs_to :serie, index: true
      t.integer :number
      t.integer :season
      t.date :air_date

      t.timestamps null: false
    end
  end
end
