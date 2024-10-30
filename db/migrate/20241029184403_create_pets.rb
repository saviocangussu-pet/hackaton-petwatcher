class CreatePets < ActiveRecord::Migration[7.1]
  def change
    create_table :pets do |t|
      t.string :name, null: false
      t.string :description, null: false

      t.references :specie
      t.references :people

      t.timestamps
    end
  end
end
