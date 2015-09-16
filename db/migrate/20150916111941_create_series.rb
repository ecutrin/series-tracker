class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string :title
      t.string :picture

      t.timestamps null: false
    end
  end
end
