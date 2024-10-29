class CreatePets < ActiveRecord::Migration[7.1]
  def change
    create_table :pets do |t|
      t.string :name

      t.references :specie
      t.references :owner, foreign_key: { to: :people }

      t.timestamps
    end
  end
end
