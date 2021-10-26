# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Review.destroy_all
Idea.destroy_all


PASSWORD = '123'

5.times do 
    User.create(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: PASSWORD
    )
end

users = User.all

10.times do
    created_at = Faker::Date.backward(days:365 * 2)
    i = Idea.create(
        title: Faker::Company.catch_phrase,
        description: Faker::Lorem.paragraph(sentence_count: 8),
        created_at: created_at,
        user: users.sample
    )
    if i.valid?
        rand(1..5).times do
            Review.create(body:Faker::Hacker.say_something_smart, idea:i, user: users.sample)
        end
    end
    i.likers = users.shuffle.slice(0, rand(users.count))
end

