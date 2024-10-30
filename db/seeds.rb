# db/seeds.rb

require 'faker'

Person.destroy_all

locations = [
  { latitude: 49.2578182, longitude: -123.2063038 }, # Vancouver
  { latitude: 40.6976312, longitude: -74.1444868 }, # New York
  { latitude: 34.0194738, longitude: -119.0355175 } # Los Angeles
]

locations.each do |location_attributes|
  5.times do
    Person.create!(
      email: Faker::Internet.unique.email,
      password: Faker::Internet.password(min_length: 8),
      owner: true,
      sitter: false,
      name: Faker::Name.name,
      phone: Faker::PhoneNumber.phone_number,
      location_attributes:
    )
  end

  2.times do
    Person.create!(
      email: Faker::Internet.unique.email,
      password: Faker::Internet.password(min_length: 8),
      owner: true,
      sitter: true,
      name: Faker::Name.name,
      phone: Faker::PhoneNumber.phone_number,
      location_attributes:,
      sitter_profile_attributes: {
        rate: Faker::Commerce.price(range: 0..20.00),
        description: Faker::Lorem.sentence(word_count: 50),
      }
    )
  end
end

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


sitter = Person.create!(
  email: 'sitter@petscreening.com',
  password: 'petscreening',
  owner: false,
  sitter: true,
  name: Faker::Name.name,
  phone: Faker::PhoneNumber.phone_number,
  location_attributes: locations.sample,
  sitter_profile_attributes: {
    rate: Faker::Commerce.price(range: 0..20.00),
    description: Faker::Lorem.sentence(word_count: 50),
  }
)

owner = Person.create!(
  email: 'owner@petscreening.com',
  password: 'petscreening',
  owner: true,
  sitter: false,
  name: Faker::Name.name,
  phone: Faker::PhoneNumber.phone_number,
  location_attributes: locations.sample,
)

Pet.create!(name: 'Fofo', specie: Specie.all.sample, owner:)

puts "Seeded #{Person.count} people"

SitterService.create!(person: sitter, pet: owner.pets.sample, start_date: 5.days.ago.to_date,
                      end_date: 2.days.ago.to_date, total_rate: 10)

