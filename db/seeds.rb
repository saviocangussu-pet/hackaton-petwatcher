# db/seeds.rb

require 'faker'
require 'fileutils'

Specie.destroy_all

species_names = [Specie::CAT, Specie::DOG]
Specie.create!(species_names.map { |name| { name: } })

puts 'Seeded Species'

Person.destroy_all

person_image_paths = Dir['db/seeds/person/*'].each.cycle
dogs_image_paths = Dir['db/seeds/pets/dogs/*'].each.cycle
cats_image_paths = Dir['db/seeds/pets/cats/*'].each.cycle

locations = [
  { latitude: 40.7128, longitude: -74.0060 }, # New York City
  { latitude: 40.7306, longitude: -73.9866 }, # Greenwich Village
  { latitude: 40.7580, longitude: -73.9855 }, # Times Square
  { latitude: 40.7851, longitude: -73.9683 }, # Central Park
  { latitude: 40.7061, longitude: -74.0086 },  # Wall Street
  { latitude: 34.0522, longitude: -118.2437 }, # Los Angeles
  { latitude: 34.0522, longitude: -118.4426 }, # UCLA
  { latitude: 34.1015, longitude: -118.3269 }, # Hollywood
  { latitude: 34.0739, longitude: -118.2402 }, # Echo Park
  { latitude: 34.1478, longitude: -118.1445 }  # Pasadena
]

locations.each do |location_attributes|
  owner = Person.create!(
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 8),
    owner: true,
    sitter: false,
    name: Faker::Name.name,
    phone: Faker::PhoneNumber.phone_number,
    location_attributes:,
    profile_image: {
      io: File.open(person_image_paths.next),
      filename: 'image'
    },
    pets_attributes: [
      { name: Faker::Creature::Dog.name, specie: Specie.find_by_name('dog'),
        description: Faker::Lorem.sentence(word_count: 50), image: {
          io: File.open(dogs_image_paths.next),
          filename: 'image'
        } },
      { name: Faker::Creature::Cat.name, specie: Specie.find_by_name('cat'),
        description: Faker::Lorem.sentence(word_count: 50), image: {
          io: File.open(cats_image_paths.next),
          filename: 'image'
        } }
    ]
  )

  person = Person.create!(
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 8),
    owner: true,
    sitter: true,
    name: Faker::Name.name,
    phone: Faker::PhoneNumber.phone_number,
    location_attributes:,
    pets_attributes: [
      { name: Faker::Creature::Dog.name, specie: Specie.find_by_name('dog'),
        description: Faker::Lorem.sentence(word_count: 50), image: {
          io: File.open(dogs_image_paths.next),
          filename: 'image'
        } },
      { name: Faker::Creature::Cat.name, specie: Specie.find_by_name('cat'),
        description: Faker::Lorem.sentence(word_count: 50), image: {
          io: File.open(cats_image_paths.next),
          filename: 'image'
        } }
    ],
    profile_image: {
      io: File.open(person_image_paths.next),
      filename: 'image'
    },
    sitter_profile_attributes: {
      rate: Faker::Commerce.price(range: 0..20.00),
      description: Faker::Lorem.sentence(word_count: 50),
      species: Specie.all
    }
  )

  2.times do
    Review.create!(
      comment: Faker::Lorem.sentence(word_count: 20), reviewable: person.sitter_profile, stars: (3..5).to_a.sample,
      person: owner
    )
  end
end

puts 'Seeded Pets'

sitter = Person.create!(
  email: 'sitter@petscreening.com',
  password: 'petscreening',
  owner: false,
  sitter: true,
  name: Faker::Name.name,
  phone: Faker::PhoneNumber.phone_number,
  pets_attributes: [
    { name: Faker::Creature::Dog.name, specie: Specie.find_by_name('dog'),
      description: Faker::Lorem.sentence(word_count: 50), image: {
        io: File.open(dogs_image_paths.next),
        filename: 'image'
      } },
    { name: Faker::Creature::Cat.name, specie: Specie.find_by_name('cat'),
      description: Faker::Lorem.sentence(word_count: 50), image: {
        io: File.open(cats_image_paths.next),
        filename: 'image'
      } }
  ],
  location_attributes: { latitude: 40.7138, longitude: -74.0050 },
  profile_image: {
    io: File.open(person_image_paths.next),
    filename: 'image'
  },
  sitter_profile_attributes: {
    rate: Faker::Commerce.price(range: 1..20.00),
    description: Faker::Lorem.sentence(word_count: 50),
    species: Specie.all
  }
)

owner = Person.create!(
  email: 'owner@petscreening.com',
  password: 'petscreening',
  owner: true,
  sitter: false,
  name: Faker::Name.name,
  phone: Faker::PhoneNumber.phone_number,
  profile_image: {
    io: File.open(person_image_paths.next),
    filename: 'image'
  },
  location_attributes: { latitude: 40.7158, longitude: -74.0055 },
  pets_attributes: [
    { name: Faker::Creature::Dog.name, specie: Specie.find_by_name('dog'),
      description: Faker::Lorem.sentence(word_count: 50), image: {
        io: File.open(dogs_image_paths.next),
        filename: 'image'
      } },
    { name: Faker::Creature::Cat.name, specie: Specie.find_by_name('cat'),
      description: Faker::Lorem.sentence(word_count: 50), image: {
        io: File.open(cats_image_paths.next),
        filename: 'image'
      } }
  ]
)

puts "Seeded #{Person.count} people"

SitterService.create!(person: sitter, pet: owner.pets.sample, start_date: 5.days.ago.to_date,
                      end_date: 2.days.ago.to_date, total_rate: 10)
