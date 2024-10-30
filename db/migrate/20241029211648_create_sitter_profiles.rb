class CreateSitterProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :sitter_profiles do |t|
      t.references :person, null:false, foreign_key: true
      t.references :location

      t.decimal :rate, precision: 10.0, scale: 2
      t.text :description

      t.timestamps
    end
  end
end
