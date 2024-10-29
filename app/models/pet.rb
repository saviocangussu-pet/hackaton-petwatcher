class Pet < ApplicationRecord
  belongs_to :owner, class_name: 'Person', foreign_key: :people_id
  belongs_to :specie
end