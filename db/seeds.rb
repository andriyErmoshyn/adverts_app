# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

Member.create!(login: "Andrew",    
                          full_name: "Main member",
                          birthday: "2000-10-03",
                          email: "anika@a.com",
                          address: "Soborna str.",
                          city: "Vinnytsya",
                          state:"Vinnytsya",
                          country: "Ukraine",
                          zip: "23001",
                          password: "password",
                          password_confirmation: "password",
                          role: 3)
Member.create!(login: "Max",    
                          full_name: "Maximus",
                          birthday: "2011-01-14",
                          email: "max@a.com",
                          address: "Soborna str.",
                          city: "Vinnytsya",
                          state:"Vinnytsya",
                          country: "Ukraine",
                          zip: "23001",
                          password: "password",
                          password_confirmation: "password",
                          role: 2)

30.times do
  login = Faker::Name.first_name
  full_name = login + "Bond"
  birthday = Faker::Date.between(100.years.ago, Date.today-20.years)
  email = Faker::Internet.email(login)
  address = Faker::Address.street_address
  city = Faker::Address.city
  state = Faker::Address.state
  country = Faker::Address.country
  zip = Faker::Address.zip  
  Member.create!(login: login,    
                          full_name: full_name,
                          birthday: birthday,
                          email: email,
                          address: address,
                          city: city,
                          state: state,
                          country: country,
                          zip: zip,
                          password: "password",
                          password_confirmation: "password",
                          role: 1)
end

members = Member.order(:created_at).take(5)
5.times do
  content = Faker::Lorem.paragraph(4)
  image = File.open(Rails.root + 'app/assets/images/road.jpg')
  members.each { |member| member.ads.create!(ad_content: content, ad_image: image) }
end
