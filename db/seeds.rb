# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Animal.destroy_all
Owner.destroy_all

10.times do
  d = Dog.create!(name: FFaker::Name.first_name)
  c = Cat.create!(name: FFaker::Name.last_name)
  rand(4).times do
    Owner.create!(name: FFaker::Name.name, animal: d)
    Owner.create!(name: FFaker::Name.name, animal: c)
  end
end
