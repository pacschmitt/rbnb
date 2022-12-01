require 'faker'

Gear.destroy_all

puts "Creating 20 fake gears..."

20.times do
  gear = Gear.new(
    name: Faker::Beer.brand,
    description: Faker::Lorem.paragraph,
    price: rand(1..100),
    category: ["Cycling", "Outdoors", "Racket-Sports", "Team-Sports", "Winter-Sports", "Dance", "Exercice", "Golf", "Precision-Sports", "Skates&Skateboards"].sample,
    address: Faker::Address.full_address
  )
  gear.user = User.all.sample
  gear.save!
end

puts "Finished!"
