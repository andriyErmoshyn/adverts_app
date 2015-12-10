FactoryGirl.define do
  factory :member do
    login        { Faker::Name.first_name }
    full_name "James Bond"
    birthday   "01.01.2000"
    email       { Faker::Internet.email}
    address   "Sobornaya str"
    city         "Vinnitsa"
    state       "Vinnitsa"
    country   "Ukraine"
    zip           "23001"
    password "password"
    password_confirmation "password"

    factory(:admin) { role 3 }

    factory :moderator  do
      role 2
      login "Moder" 
    end

    factory :user  do
      role 1
      login "User" 
    end
    factory :non_logged_in_user  do
      role nil
      login "Not_user" 
    end
    
  end
end
