class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.numeric :latitude
      t.numeric :longitude

      t.timestamps
    end
  end
end
