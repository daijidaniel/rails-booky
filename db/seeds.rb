User.all.destroy_all
Unit.all.destroy_all

user = User.create!(email: "test@test.com", password: "test123")
user.admin!

Unit.create!(name: "Amaterasu", price: 500)
Unit.create!(name: "Benzaiten", price: 500)
Unit.create!(name: "Tenjin", price: 500)
Unit.create!(name: "Hotei", price: 500)
Unit.create!(name: "Kupony", price: 200)

i = Item.create!(name: "Massage", price: 200)
i.variants << Variant.new(name: "Sports massage", price: 240)
