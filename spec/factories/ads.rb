FactoryGirl.define do
  factory :ad do
    association :member
    sequence(:ad_content) { |n| "This ad number is #{n}!" }
    ad_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test_image.png')) }
  
    factory :fail_image do
      ad_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'large_image.jpg')) }
    end
  end
end
