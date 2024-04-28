FactoryBot.define do
  factory :verb do
    association :team
    name { "MyString" }
    description { "MyText" }
  end
end
