FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "#{Faker::Name.initials(number: 5)}" }
    sequence(:last_name) { |n| "#{Faker::Name.initials(number: 5)}" }
    sequence(:email) { |n| "#{Faker::Name.initials(number: 5)}@gmail.com" }
    sequence(:password) { |n| "!@#^&Aname#{n}" }
  end
end
