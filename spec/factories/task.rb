FactoryBot.define do
    factory :task do
      title { Faker::Lorem.word }
      description { Faker::Lorem.sentence }
      association :user
    end
end