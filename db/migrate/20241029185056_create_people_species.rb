class CreatePeopleSpecies < ActiveRecord::Migration[7.1]
  def change
    create_table :people_species do |t|
      t.references :people
      t.references :specie

      t.timestamps
    end
  end
end
