# db/seeds.rb

require 'faker'

Person.destroy_all

locations = [
  { latitude: 49.2578182, longitude: -123.2063038 }, # Vancouver
  { latitude: 40.6976312, longitude: -74.1444868 }, # New York
  { latitude: 34.0194738, longitude: -119.0355175 } # Los Angeles
]

5.times do
  Person.create!(
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 8),
    owner: true,
    sitter: false,
    name: Faker::Name.name,
    phone: Faker::PhoneNumber.phone_number
  )
end

locations.each do |location_attributes|
  2.times do
    Person.create!(
      email: Faker::Internet.unique.email,
      password: Faker::Internet.password(min_length: 8),
      owner: true,
      sitter: true,
      name: Faker::Name.name,
      phone: Faker::PhoneNumber.phone_number,
      sitter_profile_attributes: {
        rate: 25,
        location_attributes:
      }
    )
  end
end

puts "Seeded #{Person.count} people"

Specie.destroy_all

species_names = [Specie::CAT, Specie::DOG]
Specie.create!(species_names.map { |name| { name: } })

puts 'Seeded Species'

Pet.create!([
              { name: 'Whiskers', specie: Specie.all.sample, owner: Person.all.sample },
              { name: 'Fido', specie: Specie.all.sample, owner: Person.all.sample },
              { name: 'Tweety', specie: Specie.all.sample, owner: Person.all.sample },
              { name: 'Rex', specie: Specie.all.sample, owner: Person.all.sample }
            ])

puts 'Seeded Pets'
