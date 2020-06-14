# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  School.create(name: Faker::Company.name)
end

100.times do
  User.create(
    name: Faker::FunnyName.name,
    gender: [0, 1, 2].sample,
    birthdate: Faker::Date.birthday(min_age: 6, max_age: 18),
    school_id: School.offset(rand(School.count)).first.id,
  )
end
