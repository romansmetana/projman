FactoryBot.define do
    factory :project do
      title { Faker::Lorem.word }
      association :user
    end
end