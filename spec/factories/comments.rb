FactoryGirl.define do

  factory :comment do
    association :member
    association :ad
    sequence(:body) { |n| "This comment number is #{n}!" }
  end  
end
