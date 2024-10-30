class CreateSitterProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :sitter_profiles do |t|
      t.references :person

      t.numeric :rate

      t.timestamps
    end
  end
end
