FactoryBot.define do
  factory :noun do
    association :team
    name { "MyString" }
    description { "MyText" }
  end
end
