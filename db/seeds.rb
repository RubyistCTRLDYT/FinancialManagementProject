# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(name: "Example User",
                    email: "example@railstutorial.org",
                    password: "foobar",
                    password_confirmation: "foobar",
                    admin: true,
                    activated: true,
                    activated_at: Time.zone.now)
keys = FinancialDatum.kinds.keys

100.times do |n|
    keys.each do |key|
        dec = key
        FinancialDatum.create!(kind: dec,
                            description: dec,
                            money: rand(0..99),
                            details: "example-#{rand(1..99)+1}", 
                            commit_time: Time.now - 31.days + n.day, 
                            user_id: 1)
    end
end

100.times do |n| 
    keys.each do |key|
        dec = key
        FinancialDatum.create!(kind: dec,
                               description: dec,
                               money: rand(-99..0),
                               details: "example-#{(rand(-99..0)-1)}", 
                               commit_time: Time.now - 31.days + n.day, 
                               user_id: 1)
    end
end

29.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now)
end