class CreateSitterProfileSpecies < ActiveRecord::Migration[7.1]
  def change
    create_table :sitter_profile_species do |t|
      t.references :sitter_profile
      t.references :specie

      t.timestamps
    end
  end
end
