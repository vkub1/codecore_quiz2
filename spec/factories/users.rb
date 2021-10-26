FactoryBot.define do
  factory :user do
    name { "Test User" }
    sequence(:email) {|n| "example-#{n}@gmail.com"}
    password { "123" }
  end
end
