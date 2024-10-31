class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :reviewable, polymorphic: true
      t.references :person

      t.integer :stars
      t.string :comment

      t.timestamps
    end
  end
end
