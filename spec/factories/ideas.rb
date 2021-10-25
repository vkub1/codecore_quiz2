FactoryBot.define do
  factory :idea do
    title {Faker::Company.catch_phrase}
    description {Faker::Lorem.paragraph(sentence_count: 8)}
    association(:user, factory: :user)
  end
end
