class Pet < ApplicationRecord
  belongs_to :owner, class_name: 'Person'
  belongs_to :specie
end
