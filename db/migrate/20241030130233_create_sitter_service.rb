class CreateSitterService < ActiveRecord::Migration[7.1]
  def change
    create_table :sitter_services do |t|
      t.references :person, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.decimal :total_rate , precision: 10, scale: 2

      t.timestamps
    end
  end
end
