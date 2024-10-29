# db/seeds.rb

require 'faker'

Person.destroy_all

10.times do
  Person.create!(
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 8),
    owner: true,
    sitter: false,
    name: Faker::Name.name,
    phone: Faker::PhoneNumber.phone_number
  )
end

puts "Seeded #{Person.count} people"

Specie.destroy_all

species_names = [Specie::CAT, Specie::DOG]
Specie.create!(species_names.map { |name| { name: name } })

puts "Seeded Species"

Pet.create!([
  { name: 'Whiskers', specie: Specie.all.sample , owner: Person.all.sample },
  { name: 'Fido', specie: Specie.all.sample , owner: Person.all.sample },
  { name: 'Tweety', specie: Specie.all.sample , owner: Person.all.sample },
  { name: 'Rex', specie: Specie.all.sample , owner: Person.all.sample }
])

puts "Seeded Pets"