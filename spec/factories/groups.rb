FactoryGirl.define do
  factory :group do
    name { "House #{Faker::GameOfThrones.house}" }
    context_id { Faker::Crypto.md5 }
  end
end
